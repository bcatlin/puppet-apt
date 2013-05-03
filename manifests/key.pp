# == Class: apt::key
#
# Adds/removes apt keys to the keyring, via 'apt-key add' or directly via 'gpg'
#
# === Parameters:
#
# [*ensure*]
#   Whether to add or remove the key.
#   Required: either 'present' or 'absent'
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
define apt::key (
  $ensure,
  $apt_key_url = 'undef',
  $key_server  = 'undef',
  $key_id      = 'undef',
) {

  if $apt_key_url != 'undef' {
    $add_command = "/usr/bin/wget -q ${apt_key_url} -O - | /usr/bin/apt-key add -"
  } elsif $key_id == 'undef' {
      fail '$key_id must be set if using $key_server'
  } else {
    $add_command = "/usr/bin/gpg --ignore-time-conflict --no-options --no-default-keyring --secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trustdb.gpg --keyring /etc/apt/trusted.gpg --keyserver ${key_server} --recv-keys ${key_id}"
  }

  case $ensure {
    'present': {
      exec { "apt-key present ${name}":
        command => $add_command,
        unless  => "/usr/bin/apt-key list | /bin/grep -c ${name}",
      }
    }
    'absent': {
      exec { "apt-key absent ${name}":
        command => "/usr/bin/apt-key del ${name}",
        onlyif  => "/usr/bin/apt-key list | /bin/grep -c ${name}",
      }
    }
    default: {
      fail "Invalid 'ensure' value '${ensure}' for apt::key ${name}"
    }
  }
}
