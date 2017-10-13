# == Define: telegraf::aggregator
#
# A Puppet wrapper for discrete Telegraf aggregator files
#
# === Parameters
#
# [*options*]
#   Hash. Plugin options for use the the aggregator template.
#
# [*sections*]
#   Hash. Some aggregators take multiple sections.
#
define telegraf::aggregator (
  $plugin_type = $name,
  $options     = undef,
  $suboptions  = undef,
  $sections    = undef,
) {
  include telegraf

  if $options {
    validate_hash($options)
  }

  if $sections {
    validate_hash($sections)
  }

  Class['::telegraf::config']
  -> file { "${telegraf::config_folder}/aggregator-${name}.conf":
    content => template('telegraf/aggregator.conf.erb'),
  }
  ~> Class['::telegraf::service']
}
