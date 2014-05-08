Puppet motd module
===========================

This module allows you to change the /etc/motd file in *nix systems.
It was inspired by the [saz/puppet-motd](https://github.com/saz/puppet-motd) module.

Usage:

  ```puppet
  class {'motd': }
  ```
  The hiera entry should be like this:

  ```yaml
---
motd::use_hiera: 'true'
motd_messages:
  "motd1":
    message: "Message 1"
    order: '100'
  "motd2": 
    message: "Message 2"
    order: '101'
  ```

### NOTE: 
  * The hiera motd_messages hash keys should not include spaces.

## Other class parameters
  * ensure: present or absent, default: present
  * motd_file: string, default: OS specific. Set motd_file, if platform is not supported.
  * supported: true or false, default: OS specific
  * use_hiera: true or false, default: false

License
=======
Licensed under the Apache License, Version 2.0
