# == Define: apt::customrepo
#
# Adds a custom apt repository.
#
# == Actions:
#
# Deploys a file in /etc/apt/sources.list.d, either via template or static file
# Adds a key to the custom repository.
#
# === Parameters:
#
# [*list_source*]
#   'source' variable for the .list file (specify this or 'list_content' below)
#   Default: 'undef' (string)
#
# [*list_content*]
#   'content' variable for the .list file (specify this or 'list_source' below)
#   Example: 'http://my.keyserver.tld/mykey.asc'
#   Default: 'undef' (string)
#
# [*apt_key_url*]
#   The HTTP URL for downloading the key file.
#   Example: 'http://my.keyserver.tld/mykey.asc'
#   Default: 'undef' (string)
#
# [*key_server*]
#   The server location for downloading the key.
#   Example: 'keyserver.ubuntu.com'
#   Must be used with 'key_id' below.
#   Default: 'undef' (string)
#
# [*key_id*]
#   The ID of the key to download from the above 'key_server' location.
#   Example: '643DC6BD56580CEB1AB4A9F63B22AB97AF1CDFA9'
#   Default: 'undef' (string)
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
  $list_source  = 'undef',
  $list_content = 'undef',
  $key_url      = 'undef',
  $key_server   = 'undef',
  $key_id       = 'undef',
) {

  include apt::update

  if $list_source == 'undef' and $list_content == 'undef' {
    fail 'Must specify one of 'list_source' or 'list_content'
  } elseif $list_source != 'undef' {
    File["/etc/apt/sources.list.d/${name}.list"] {
      source => $list_source,
    }
  } else {
    File["/etc/apt/sources.list.d/${name}.list"] {
      content => $list_content,
    }
  }

  file { "/etc/apt/sources.list.d/${name}.list":
    ensure => file,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  apt::key { $name:
    ensure      => present,
    apt_key_url => $key_url,
    key_server  => $key_server,
    key_id      => $key_id,
    notify      => Exec['apt_update'],
    require     => File["/etc/apt/sources.list.d/${name}.list"],
  }


}
