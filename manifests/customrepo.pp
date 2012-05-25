define apt::customrepo ($source_location, $key_url) {

  include apt::update

  # Lay down the repo file
  file { "/etc/apt/sources.list.d/${name}.list":
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///${source_location}",
    notify  => Apt::Key[$name],
  }

  # Import the key
  apt::key { $name:
    ensure      => present,
    apt_key_url => $key_url,
    notify      => Exec['apt_update'],
  }


}
