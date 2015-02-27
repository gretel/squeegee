#
# Copyright 2015, Adobe Systems Inc.
#
# Tom Hensel <adobe@jitter.eu>
#
# All rights reserved - Do Not Redistribute
#

config = node['win-dev']['config']

homebrew_tap 'caskroom/cask'

package 'brew-cask' do
  action :install
end

homebrew_cask 'virtualbox'

gem_package 'bundler' do
  action :upgrade
end
