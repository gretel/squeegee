#
# Copyright 2015, Adobe Systems Inc.
#
# Tom Hensel <adobe@jitter.eu>
#
# All rights reserved - Do Not Redistribute
#

log 'Including recipes ...'

include_recipe 'win-dev::prepare'
include_recipe 'win-dev::provision'

if node.attribute?('ec2')
  # Installs cloud ops base package (ntp, ...)
  include_recipe 'cloudops::default'

  # Install Splunk Forwarder
  include_recipe 'sc-splunk::default'

  # TODO adjust path
  # Add logs of application
  sc_splunk 'win-dev' do
    path "/*.log"
    sourcetype 'win-dev'
    action :create
  end
end

log 'All done!'
