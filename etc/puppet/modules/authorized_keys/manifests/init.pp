# == Class: authorized_keys
#
# Class allowing the distribution of ssh authorized_keys file.
# The class is based on the idea of segregating between keys, OS users and roles (who can access what).
#
# === Parameters
#
# [*authorized_keys*]
#   Hash of ssh public keys which will be created via ssh::authorized_keys.
#
# [*rolesusers*]
#   Hash of OS users and corresponding roles
#
# [*rolesauth*]
#   Hash of roles and corresponding ssh public keys
#
# === Examples
#
# $authorized_keys = {
#   'John.Doe' => {
#     key     => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAnGspY8p4ZoWlQ5RNLP/FzvB4WfaFdjnci0p7+oge9/xkBbvJscBlEAbmPnufT/4dM+fKDysE9Py0jcX7ymcLh5KzP7hhvRBW98O8u/UdEJmHENccJu/y+Uf4Onl1nHynLlg72OOvRGw81sSaBJsKTIJGBORqU2R0lNKtEjlKlsKfQi1cATwwFyglrLrAl8cX3j44XPeBTWEPwFjkJM8D6CRH15809fcS4byMnnXbEBkFOWGngGBBkUt6Ari4xbOG7XF9nJO3xm/mMubFQrAHCLIYYyXq5c7FFnOH/vlefM2zXCa6+HNb4BuupyY9iKPZ9Mwwhxtk1wi0ncU8qvZJ/w==' 
#     type    => 'ssh-rsa'
#     options => 'command="/bin/sh"',
#   }
# }
# $rolesusers = {
#  'root' => {
#    home  => "/root",
#    roles => ['Role1','Role2'],
#   }
# }
# $rolesauth = {
#   'Role1' => ['John.Doe'],
#   'Role2' => ['John.Doe'],  
#   }
# }
#
#
#
#
# class { 'sudo': sudoers => $sudoers }
#
# === Authors
#
# Virgil Chereches <virgil.chereches@gmx.net>
#
#
#
class authorized_keys ($authorized_keys=hiera_hash('authorized_keys::authorized_keys_hash',{}),$rolesusers=hiera_hash('authorized_keys::rolesusers_hash',{}),$rolesauth=hiera_hash('authorized_keys::rolesauth_hash',{}))
{
  require authorized_keys::validate
  create_resources('authorized_keys::authkeyfile',$rolesusers)
}

