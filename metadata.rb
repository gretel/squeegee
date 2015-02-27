name             'win-dev'
maintainer       'Tom Hensel for Adobe Systems GmbH'
maintainer_email 'adobe@jitter.eu'
license          'All rights reserved'
description      'Provisions a portable Windows Server 2012 R2 environment and provides a development environment for Chef cookbooks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# # https://git.corp.adobe.com/cloudops-cookbooks/cloudops-base
# depends 'cloudops'

# https://github.com/opscode-cookbooks/homebrew
depends 'homebrew'
