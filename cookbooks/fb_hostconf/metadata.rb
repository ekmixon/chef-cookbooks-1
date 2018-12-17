# Copyright (c) 2018-present, Facebook, Inc.
name 'fb_hostconf'
maintainer 'Facebook'
maintainer_email 'noreply@facebook.com'
license 'BSD-3-Clause'
description 'Configures /etc/host.conf'
source_url 'https://github.com/facebook/chef-cookbooks/'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
supports 'centos'
supports 'debian'
supports 'ubuntu'
depends 'fb_helpers'
