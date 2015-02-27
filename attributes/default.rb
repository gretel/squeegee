#
# Copyright 2015, Adobe Systems Inc.
#
# Tom Hensel <adobe@jitter.eu>
#
# All rights reserved - Do Not Redistribute
#

default['win-dev']['deploy'].tap do |dply|

  # create user's writable ('shared') directories. path recursion is enabled.
#  dply['writable_dirs'] = ['bin', 'conf', 'log', 'run', 'zk-log-index', 'zk-install', 'zk-log', 'zk-snapshot', 'zk-transaction' ]

  # url of exhibitor package to install
#  dply['exhibitor_tgz_url']      = 'https://github.com/gretel/exhibitor/releases/download/1.5.3/exhibitor-standalone-1.5.3-SNAPSHOT.tar.gz'

  # # per environment overrides
  # c_env = node.chef_environment
  # case c_env
  # when /STAGE-AN1/
  #   app['region'] = 'ap-northeast-1'
  # when /STAGE-EW1/
  #   app['region'] = 'eu-west-1'
  # when /STAGE-UE1/
  #   app['region'] = 'us-east-1'
  # when /PROD-AN1/
  #   app['region'] = 'ap-northeast-1'
  # when /PROD-EW1/
  #   app['region'] = 'eu-west-1'
  # when /PROD-UE1/
  #   app['region'] = 'us-east-1'
  # when '_default'
  #   # ignore, might be case on testing
  # else
  #   raise RuntimeError.new("undefined environment: #{c_env}")
  # end

end
