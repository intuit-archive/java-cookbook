#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright (C) 2013 Intuit, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

java_home = node['java']['java_home']

package 'jdk' do
  version "#{node['java']['jdk_version']}"
end

ruby_block 'set-env-java-home' do
  block do
    ENV["JAVA_HOME"] = java_home
  end
  not_if { ENV["JAVA_HOME"] == java_home }
end

file '/etc/profile.d/jdk.sh' do
  content <<-EOS
    export JAVA_HOME=#{java_home}
  EOS
  mode 0755
end
