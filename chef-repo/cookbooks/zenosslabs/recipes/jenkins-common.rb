#
# Cookbook Name:: zenosslabs
# Recipe:: jenkins-common
#
# Copyright 2011, Zenoss, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Create jenkins user.
user "jenkins" do
    comment "Jenkins"
    home "/var/lib/jenkins"
end


# Setup keys and trust.
directory "/var/lib/jenkins/.ssh" do
    owner "jenkins"
    group "jenkins"
    mode "0700"
    action :create
end

%w{id_rsa id_rsa.pub known_hosts authorized_keys}.each do |file|
    case file
    when "id_rsa", "authorized_leys"
        mode = 0600
    else
        mode = 0644
    end

    cookbook_file "/var/lib/jenkins/.ssh/#{file}" do
        source "jenkins.ssh/#{file}"
        mode { mode }
        owner "jenkins"
        group "jenkins"
    end
end