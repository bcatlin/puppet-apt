class apt::cron::install {
  package {
    'cron-apt': ensure => latest,
  }
}
