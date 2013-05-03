# == Define: apt::customrepo
#
# Adds a custom apt repository.
#
# == Actions:
#
# Deploys a file in /etc/apt/sources.list.d/
# Adds a key to the custom repository.
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
define apt::customrepo (
  $source_location,
  $key_url    = 'undef',
  $key_server = 'undef',
  $key_id     = 'undef',
) {

  include apt::update

  # == Repo file
  file { "/etc/apt/sources.list.d/${name}.list":
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/${source_location}",
  }

  # == Key
  apt::key { $name:
    ensure      => present,
    apt_key_url => $key_url,
    key_server  => $key_server,
    key_id      => $key_id,
    notify      => Exec['apt_update'],
    require     => File["/etc/apt/sources.list.d/${name}.list"],
  }


}
