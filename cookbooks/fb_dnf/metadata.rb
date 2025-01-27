# Copyright (c) 2021-present, Facebook, Inc.
name 'fb_dnf'
maintainer 'Facebook'
maintainer_email 'noreply@facebook.com'
license 'Apache-2.0'
description 'Installs/Configures dnf'
source_url 'https://github.com/facebook/chef-cookbooks/'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
supports 'centos'
supports 'fedora'
depends 'fb_helpers'
depends 'fb_yum_repos'
