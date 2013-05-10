# == Class: apt::exec
#
# This class provides 'exec' hooks to trigger 'apt-get update' and
# 'apt-get clean'.
#
# 'apt-get update' is used by the apt::customrepo and apt::sources modules, but can be called from
# anywhere, as long as apt::update is included in the node's manifest (this is
# the default behaviour when using 'include apt').
#
# == Actions:
#
# Refreshes the apt cache, only if either the cache doesn't exist, or new files
# are found in /etc/apt
#
# Also provides a refresh-only hook to clear the apt cache
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
class apt::exec {

  exec {
    'apt_clean':
      command     => '/usr/bin/apt-get clean',
      refreshonly => true;

    'apt_update':
      command => '/usr/bin/apt-get update',
      onlyif  => '/bin/sh -c \'[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null\'';
  }
}
