# Copyright (c) 2016-present, Facebook, Inc.
name 'fb_dcrpm'
maintainer 'Facebook'
maintainer_email 'noreply@facebook.com'
source_url 'https://github.com/facebook/chef-cookbooks/'
license 'Apache-2.0'
description 'Installs/Configures dcrpm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
supports 'centos'
depends 'fb_helpers'
depends 'fb_logrotate'
depends 'fb_timers'
