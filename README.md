# squeegee

Installs/configures a set of tools to provide dynamic scaling for DynamoDB. Mainly, `dynamo-autoscale` provides the functions to scale up.. and down. Haz CLI interface. Managed bye Eye (a Ruby supervisor) `dynamo-autoscale` runs as a daemon.

The documentation on the fork of dynamo-autoscale used by this cookbook is at [squeegee](https://github.com/gretel/squeegee/blob/master/README.md) on Github.

## Forked - what is different

The original [authors](https://github.com/invisiblehand/dynamo-autoscale/) do currently neither maintain the project nor do merge pull requests. So i got on with this fork! Hope to get my work merged upstream anytime soon.

- Command line interface (CLI) (replacing an executable and various scripts)
- Streamlined workflow using a chain of commands (`check_config`, `check_ruleset`, `pull_cw_data`, `test_simulate`, `start`) using the CLI
- Revamped logging (syntactically, semantically, and using Yell yo!)
- Can be installed and used without any superuser privileges
- Supports EC2 region 'eu-central-1'
- Works on Ruby 2.1 (tested using 2.1.5 as on AMI)
- Tests migrated to RSpec 3
- Fixed some logic glitches (nothing major though)
- Improved robustness (added sanity checks, exception handling)
- Reduced gem-dependencies and disabled some dusky codedpaths
- Overall code cleanup and various tweaks applied
- Added documentation

## $$$ Warning

**IMPORTANT**: Please read carefully before continuing! This tool, if used incorrectly, has the potential to cost you huge amounts of money. Proceeding with caution is mandatory, as noone but you can be held responsible for misuse that leads to excessive cost on your AWS account.

The command line tool has a `--dry_run` flag to test your configuration before actually changing the provisioned throughput values. It is highly recommended that you *first try running dry* and inspect the output to make sure this tool works as expected. You will have to change an attribute of the cookbook to have scaling enabled, please read on.

## Supported Target Platforms

Amazon Linux 2009.09.01

### Building Requirements

There is no gem of this fork in the Rubygems index currently. Therefore, you need to build the gem and paste it to the cookbook. Please have the following tools ready:

- UNIX OS
- Git
- Ruby 2
- Ruby Gems
- Bundler

### Building the Gem

Checkout, bundle, rake, copy ...

```
$ git clone --depth 1 https://github.com/gretel/squeegee.git
$ cd squeegee
$ bundle
$ rake build
$ cp squeegee-x-y-z.gem path/to/dynamo-autoscale-cookbook/files/default
```

#### Change Attributes

The attributes (`attributes/default.rb`) need to be changed to reflect the Gem's version:

```
  dply['gem_name']    = 'squeegee'
  dply['gem_version'] = 'x.y.z'
```

## Supervision

Let's have a little intro on how the executable file in the Gem ends up to be a supervisioned dameon process. On startup the following happens:

Operating system starts ➙ Init Process ➙ `/etc/init.d/dynamo-autoscale start` ➙ Eye at `/usr/local/bin/eye` get started loads configuration for process from `/home/dynamo/etc/dynamo-autoscale.eye` ➙ Eye starts executable `/usr/local/bin/dynamo-autoscale` and passes options ➙ Eye supervises process ➙ ...

Therefore, the cookbook contains templates to implement this flow:

- Configuration file of squeegee
  (`templates/default/dynamo-autoscale.yml.erb`)
- Service descriptor for Eye supervisor
  (`templates/default/dynamo-autoscale.eye.erb`)
- Shell script for `init.d` to start the Eye Supervisor
  (`templates/default/eye_init.rb`)
- Login script for the deployment user
  (`templates/default/dot_profile`)

In general, you should only need to change the first template (`templates/default/dynamo-autoscale.yml.erb`) to change the configuration to your actual needs.

## Logging

All output (`STDOUT`, `STDERR`) the process dumps is redirected to Eye which stores it in logfiles at `/home/dynamo/log`. Please see below on `Log Agents and Signals` for more details.
Logfile rotation is done by [eye-rotate](https://github.com/kostya/eye-rotate) - please see the template file at `templates/default/dynamo-autoscale.eye.erb` for configuration.

## Attributes

Please check out the inline-documenation in `attributes/default.rb` on how to fine-grain the taste of this cookbook.

### Dry-Run

For your security and protection the throughput values will _not_ be changed until you disable the `--dry_run` option enabled per default when using this cookbook. Please test well before disabling this:

```
  # do not forget to change this for production use!
  app['dry_run'] = false
```

## Manual Interference

In case of any issues or if you head on with development of this cookbook logging in via SSH can be helpful to check on logfiles and stuff. Please loging as the default `ec2-user` first:

```
$ ssh -i mykey.pem ec2-user@ip.of.ho.st
```

### Become somebody else

To use the CLI of Eye and to not mess up with file permissions `sudo` is used:

```
$ sudo -u dynamo -i bash
```

### Have an Eye on the daemon

OK, bash's profile script will welcome you with the status of the `daemon` process which belongs to our application `squeegee`:

```
status: squeegee
  daemon .......................... unmonitored (stop by user at 20 Nov 14:24)
```

Oh *doh*, it is not running! Let's see what Eye can do for us:

```
$ eye help
Commands:
  eye break MASK[,...]         # break chain executing
  eye check CONF               # check config file syntax
  eye delete MASK[,...]        # delete app,group or process
  eye explain CONF             # explain config tree
  eye help [COMMAND]           # Describe available commands or one specific command
  eye history [MASK,...]       # processes history
  eye info [MASK]              # processes info
  eye load [CONF, ...]         # load config (run eye-daemon if not) (-f foreground load)
  eye match MASK[,...]         # match app,group or process
  eye monitor MASK[,...]       # monitor app,group or process
  eye oinfo                    # onelined info
  eye quit                     # eye-daemon quit
  eye restart MASK[,...]       # restart app,group or process
  eye signal SIG MASK[,...]    # send signal to app,group or process
  eye start MASK[,...]         # start app,group or process
  eye status NAME              # return exit status for process name 0-up, 3-unmonitored
  eye stop MASK[,...]          # stop app,group or process
  eye trace [MASK]             # tracing log(tail + grep) for app,group or process
  eye unmonitor MASK[,...]     # unmonitor app,group or process
  eye user_command CMD [MASK]  # execute user_command (dsl command)
  eye version                  # version
  eye watch [MASK]             # interactive processes info
  eye xinfo                    # eye-deamon info (-c show current config)
```

We should try to find out what is wrong, let's learn from history:

```
$ eye history daemon
squeegee:daemon
20 Nov 14:20 - start          (start by user)
20 Nov 14:20 - unmonitor      (flapping)
20 Nov 14:20 - restore        (crashed)
```

Flapping! The process did start and stopped immeadiately. After a few times, Eye detects this flapping (as configured in `templates/default/squeegee.eye.rb`) and suspends the process for some time. The logfile should give us a hint:

```
$ eye trace daemon
2014-11-20 14:23:42.723 [ INFO] 8468 ip-a-b-c-d : [common] Version x.y.z (working in '/home/deploy/run/data') starting up...
error:
Missing Credentials.

Unable to find AWS credentials.
...
```

Oh, looks like our AWS credentials are missing or token authentication is not working. So we need to use the right ones to fix this issues. For now, we could manually edit the configuration (`~/etc/squeegee.yml`) and let Eye kick the process up and keep a tail on the logfile:

```
$ eye start daemon
...
$ eye trace daemon
```

### Startup behaviour

If you would like to bring up the process manually (not automatically by `init` on boot) please change the according attribute:

```
  # actually start the servie or just set it up
  dply['service_start'] = false
```

This can be useful for development and testing purposes, so it won't do nothing until you come and master it.

## Signalling

The `dynamo-autoscale` process responds to the `QUIT`, `SIGUSR1` and `SIGUSR2` signals.

### QUIT

The process will quit gracefully. Eye is configured to send this signal to have the process quit.

### SIGUSR1: Dump JSON

If you send `SIGUSR1` the process will dump all data it stores on the tables to `STDERR` in JSON format. This can be used to have a logging agent grab the data by following the process' logfile.

The data can be easily parsed, as the code generating it is super simple:

``` ruby
STDERR.puts tables.to_json
```

Please see [lib/dynamo-autoscale/local_data_poll.rb](https://github.com/gretel/squeegee/blob/master/lib/dynamo-autoscale/local_data_poll.rb) on Github for the parser used in the tool itself.

### SIGUSR2: Human readble statistics

If you send `SIGUSR2` the process will output human readable statistics to `STDERR`:

```
Caught signal USR2! Statistics:
      Upscales : 0
    Downscales : 0
  Lost r/units : 0.0 (0.0%)
  Lost w/units : 0.0 (0.0%)
   Lost r/cost : $0.0 (0.0%)
   Lost w/cost : $0.0 (0.0%)
 Total r/units : 173.0
 Total w/units : 146.0
  Total r/cost : $0.03
  Total w/cost : $0.02
Wasted r/units : 173.0 (100.0%)
Wasted w/units : 146.0 (100.0%)
 Wasted r/cost : $0.03 (100.0%)
 Wasted w/cost : $0.02 (100.0%)
```

Poor stats.. Please see [lib/dynamo-autoscale/table_tracker.rb](https://github.com/gretel/squeegee/blob/master/lib/dynamo-autoscale/table_tracker.rb) for the code putting this out.

## Log Agents and Signals

You would like to have a logging agent gather statistics once per day? Your agent is configured to read the logfile at `~/log/app_squeegee.log` as set in `dply['service_log']`? Great! All you need to do is to trigger the signal. Please keep in mind the agent has to run the command as the deployment user (`dynamo`):

```
$ sudo -u dynamo -i bash -c 'eye signal SIGUSR1 daemon'
```

Internally, Eye will lookup the process id using the pidfile (see `dply['service_pid']`) and send the signal there. Upon reception, the process will dump JSON to `STDERR` which is in turn piped to Eye, stored in the logfile (see `dply['service_log']`) and finally gathered by your agent.

## Putting it in your Cookbooks

### dynamo-autoscale-cookbook::default

Include `dynamo-autoscale-cookbook` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[dynamo-autoscale-cookbook::default]"
  ]
}
```

## License and Authors

Author:: Tom Hensel (adobe@jitter.eu (tom87213@adobe.com))
