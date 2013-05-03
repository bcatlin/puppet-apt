# == Class: apt
#
# This class configures apt, including adding proxies & repo localisation.
#
# == Actions:
#
# Conditionally configures an HTTP proxy server for apt
# Adds localisation (defaulting to 'us') to the default repositories
# Conditionally enables/disables the universe/multiverse/partner repositories
# Provides a hook to trigger an `apt-get update`
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
class apt {
  include apt::params
  include apt::sources
  include apt::proxy
  include apt::update
}
