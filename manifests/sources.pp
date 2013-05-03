# == Class: apt::sources
#
# This class handles configuring the default sources.list file.
#
# == Actions:
#
# Overwrites the default /etc/apt/sources.list file, conditionally enabling
# universe, multiverse, partner & extras repositories. See manifests/params.pp.
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
class apt::sources {

  file { '/etc/apt/sources.list':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apt/sources.list.erb'),
    notify  => Exec['apt_update'],
  }

}
