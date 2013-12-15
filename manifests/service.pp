# == Class: redis::service
#
# This class manages the redis service
#
#
# === Parameters
#
# See the init.pp for parameter information.  This class should not be directly called.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class redis::service {
  realize(Sredis['redis'])
}
