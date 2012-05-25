puppet-apt
===============

This module is my own apt interpretation, mainly apt::customrepo

=== Example ===

apt::customrepo { 'repo':
  key_url         => 'http://www.site.com/some.key',
  source_location => 'modules/apt/repo.list',
}

