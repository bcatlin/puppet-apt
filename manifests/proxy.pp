# == Class: apt::proxy
#
# This class handles configuring an HTTP proxy for apt.
#
# == Actions:
#
# Creates '/etc/apt/apt/conf.d/02proxy' with the URL of the configured proxy
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) 2013 Craig Watson
# Published under the GNU General Public License v3
#
class apt::proxy {

  if $apt::params::proxy_server != 'undef' {
    file { '/etc/apt/apt.conf.d/02proxy':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "Acquire::http::Proxy \"http://${apt::params::proxy_server}\";",
    }
  } else {
    file { '/etc/apt/apt.conf.d/02proxy' :
      ensure => absent,
    }
  }

}
