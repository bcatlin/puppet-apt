# == Define: apt::customrepo
#
# Adds a custom apt repository.
#
# == Actions:
#
# Deploys a file in /etc/apt/sources.list.d, via template or static file. Adds
# a key to the custom repository, and triggers an 'apt-get clean' and 'apt-get
# update'.
#
# === Parameters:
#
# [*ensure*]
#   - Whether to remove or deploy the .list file
#   Example: present
#   Default: present (Puppet ensure)

# [*list_source*]
#   - Source file to deploy as the .list file (takes precendence over
#     the 'list_template' variable below)
#   Example: 'puppet:///modules/mymodule/myrepo.list'
#   Default: 'undef' (string)
#
# [*list_template*]
#   - Template to dynamically deploy the .list from (useful for custom logic)
#   Example: 'mymodule/myrepo.list.erb'
#   Default: 'apt/repo.list.erb' (string)
#
# [*repo_url*]
#   - URL for the repository, used with the default 'list_template'
#  Example: 'http://archive.getdeb.net/ubuntu'
#  Default: 'undef' (string)
#
# [*repo_release*]
#   - Release codename for the repository, used with the defaut 'list_template'
#     Useful when your repository is for a different release
#   Example: 'precise'
#   Default: $::lsbdistcodename (top-level fact - string)
#
# [*repo_component*]
#   - Component to load from the repository
#   Example: 'main'
#   Default: 'undef' (string)
#
# [*repo_src*]
#   - Whether or not to add a deb-src line to the .list file
#   Example: true
#   Default: false (boolean)
#
# [*key_name*]
#   The name of the apt::key resource created.
#   Example: 'my_key'
#   Default: $name (string)
#
# [*key_url*]
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
  $ensure         = present,
  $list_source    = 'undef',
  $list_template  = 'apt/repo.list.erb',
  $repo_url       = 'undef',
  $repo_release   = $::lsbdistcodename,
  $repo_component = 'undef',
  $repo_src       = false,
  $key_name       = $name,
  $key_url        = 'undef',
  $key_server     = 'undef',
  $key_id         = 'undef',
) {

  include apt::exec

  file { "/etc/apt/sources.list.d/${name}.list":
    ensure => $ensure,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    notify => Exec['apt_clean'],
  }

  if $list_source != 'undef' {
    File ["/etc/apt/sources.list.d/${name}.list"] {
      source => $list_source,
    }
  } else {
    if $list_template == 'apt/repo.list.erb' {
      if $repo_url == 'undef' or $repo_component == 'undef' {
        fail 'Must specify $repo_url and $repo_component if using the default template'
      }
    }

    File ["/etc/apt/sources.list.d/${name}.list"] {
      content => template($list_template),
    }
  }

  if !defined(Apt::Key[$key_name]) {
    apt::key { $key_name:
      ensure      => $ensure,
      apt_key_url => $key_url,
      key_server  => $key_server,
      key_id      => $key_id,
      notify      => Exec['apt_clean'],
      require     => File["/etc/apt/sources.list.d/${name}.list"],
    }
  }

}
