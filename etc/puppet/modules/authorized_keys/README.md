# brutus777/authorized_keys

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
    * [What [Modulename] affects](#what-[modulename]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [Modulename]](#beginning-with-[Modulename])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The module distributes authorized_keys file in any user home dir based on roles. The roles, keys and user/role assignement is kept in hiera but can be also specified in class manifest.
The module was tested on Puppet 2.7.

##Module Description

The module does the following tasks: parse hiera structures and validate all three hashes one against the other; if the validate is succesfull it will explode a template which populate the lines of authorized_keys files for each user under authorized_keys managament.

##Setup

The following type of hiera structures or local hashes must be created:

    security::authorized_keys:
        John.Doe:
          key: AAAAB3NzaC1yc2EAAAABIwAAAQEAnGspY8p4ZoWlQ5RNLP/FzvB4WfaFdjnci0p7+oge9/xkBbvJscBlEAbmPnufT/4dM+fKDysE9Py0jcX7ymcLh5KzP7hhvRBW98O8u/UdEJmHENccJu/y+Uf4Onl1nHynLlg72OOvRGw81sSaBJsKTIJGBORqU2R0lNKtEjlKlsKfQi1cATwwFyglrLrAl8cX3j44XPeBTWEPwFjkJM8D6CRH15809fcS4byMnnXbEBkFOWGngGBBkUt6Ari4xbOG7XF9nJO3xm/mMubFQrAHCLIYYyXq5c7FFnOH/vlefM2zXCa6+HNb4BuupyY9iKPZ9Mwwhxtk1wi0ncU8qvZJ/w==
          type: ssh-rsa
          options: command="/bin/sh"
    
    security::rolesauth:
        Role1:
          - John.Doe
    
    security::rolesusers:
        root:
          home: "/root"
          roles:
            - Role1

###What [Modulename] affects

* The module changes the authorized_keys file; no existing keys are preserved
* The module assumes that users are already provisioned - most probably the user management module should be have an ordering relationship with this module 

  

##Usage

    $authorized_keys = {
      'John.Doe' => {
        key     => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAnGspY8p4ZoWlQ5RNLP/FzvB4WfaFdjnci0p7+oge9/xkBbvJscBlEAbmPnufT/4dM+fKDysE9Py0jcX7ymcLh5KzP7hhvRBW98O8u/UdEJmHENccJu/y+Uf4Onl1nHynLlg72OOvRGw81sSaBJsKTIJGBORqU2R0lNKtEjlKlsKfQi1cATwwFyglrLrAl8cX3j44XPeBTWEPwFjkJM8D6CRH15809fcS4byMnnXbEBkFOWGngGBBkUt6Ari4xbOG7XF9nJO3xm/mMubFQrAHCLIYYyXq5c7FFnOH/vlefM2zXCa6+HNb4BuupyY9iKPZ9Mwwhxtk1wi0ncU8qvZJ/w=='
        type    => 'ssh-rsa'
        options => 'command="/bin/sh"',
      }
    }
    $rolesusers = {
     'root' => {
       home  => "/root",
       roles => ['Role1','Role2'],
      }
    }
    $rolesauth = {
      'Role1' => ['John.Doe'],
      'Role2' => ['John.Doe'],
      }
    }
    
    authorized_keys{ 'authorized_keys':
      authorized_keys => $authorized_keys,
      rolesusers      => $rolesusers,
      rolesauth       => $rolesauth,
    }

For hiera use:

    authorized_keys{ 'authorized_keys':
      authorized_keys => hiera_hash('security::authorized_keys',{}),
      rolesusers      => hiera_hash('security::rolesusers',{}),
      rolesauth       => hiera_hash('security::rolesauth',{}),
    }
#
#
##Reference

The module defines the following classes and defined types:

authorized_keys class: wrapper class, it is calling authorized_keys::validate and create_resources

authorized_keys::validate: validation class, cross-validate hiera hashes

authorized_keys::validatekeys: validate keys defined type, used to call authorized_keys::parsevalidate_array

authorized_keys::validateroles: validate roles defined type, used to call authorized_keys::parsevalidate_array

authorized_keys::parsevalidate_array: defined type used to check if a value exists in an array

authorized_keys::authkeyfile: defined type used to explode the template in files



##Limitations

Tested on RedHat OS; should work on any other Linux distribution.

##TO DO

Add hash validation in validate*.pp
