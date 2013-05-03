# == Class: apt::params
#
# This class handles all parameters for this module
#
# == Actions:
#
# None.
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
class apt::params {
  $proxy_server      = hiera('apt/proxy','undef')
  $locale            = hiera('apt/locale','us')
  $enable_universe   = hiera('apt/enable_universe',true)
  $enable_multiverse = hiera('apt/enable_multiverse',true)
  $enable_backports  = hiera('apt/enable_backports',true)
  $enable_partner    = hiera('apt/enable_partner',false)
  $enable_extras     = hiera('apt/enable_extras',false)
}
