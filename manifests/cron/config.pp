class apt::cron::config {
  $sysadmin_email = hiera('sysadmin_email')

  file { '/etc/cron-apt/config':
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('apt/cron/config.erb'),
    require => Package['cron-apt'],
  }
}
