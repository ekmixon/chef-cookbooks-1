#
# Cookbook Name:: fb_networkd
# Recipe:: default
#
# Copyright (c) 2021-present, Facebook, Inc.
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unless node.systemd?
  fail 'fb_networkd: this cookbook is only supported on systemd hosts'
end

node.default['fb_systemd']['networkd']['enable'] = true

fb_networkd 'manage configuration'

execute 'networkctl reload' do
  command '/bin/networkctl reload'
  action :nothing
end

fb_helpers_request_nw_changes 'manage' do
  action :nothing
  delayed_action :cleanup_signal_files_when_no_change_required
end

# Set up execute resources to reconfigure network settings so that they can be
# notified by and subscribed to from other recipes.
node['network']['interfaces'].to_hash.each_key do |iface|
  next if iface == 'lo'

  execute "networkctl reconfigure #{iface}" do
    command "/bin/networkctl reconfigure #{iface}"
    action :nothing
  end

  # Link configurations are configured by systemd-udevd (through the
  # net_setup_link builtin as mentioned in the systemd.link man page).
  # To re-apply link configurations, either an "add", "bind", or "move"
  # action must be sent on the device.
  # This should use `udevadm test-builtin` in the future but --action wasn't
  # added to builtins until
  # https://github.com/systemd/systemd/pull/20460.
  execute "udevadm trigger #{iface}" do
    command "/bin/udevadm trigger --action=add /sys/class/net/#{iface}"
    action :nothing
  end
end

# Conditionally fail if a dynamic address was found on one of the interfaces.
# Examples of dynamic addresses include SLAAC or DHCP(v6).
whyrun_safe_ruby_block 'validate dynamic address' do
  not_if { node['fb_networkd']['allow_dynamic_addresses'] }
  block { node.validate_and_fail_on_dynamic_addresses }
end
