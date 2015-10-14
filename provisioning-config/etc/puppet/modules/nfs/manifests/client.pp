# File::      <tt>client.pp</tt>
# Author::    Sebastien Varrette (Sebastien.Varrette@uni.lu)
# Copyright:: Copyright (c) 2011 Sebastien Varrette
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: nfs::client
#
# Configure and manage NFS client
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of nfs::client
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import nfs::client
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'nfs::client':
#             ensure => 'present'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class nfs::client( $ensure = $nfs::params::ensure ) inherits nfs::params
{
    info ("Configuring nfs::client (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("nfs::client 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include nfs::client::common::debian }
        redhat, fedora, centos: { include nfs::client::common::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}
