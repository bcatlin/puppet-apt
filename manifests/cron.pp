class apt::cron {
  include apt::cron::install
  include apt::cron::config
}
