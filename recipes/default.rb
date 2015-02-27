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

log 'All done!'
