# == Class: redis::install
#
# This class installs the redis package
#
#
# === Parameters
#
# See the init.pp for parameter information.  This class should not be directly
# called.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class redis::install ($packages, $version = 'latest', $manage_repo = false) {
  validate_string($packages)
  validate_string($version)
  validate_bool($manage_repo)

  if $::operatingsystem == 'ubuntu' {
    if $manage_repo {
      # Only add apt source if we're managing the repo
      include 'apt'

      # Only use PPA when necessary.
      apt::ppa { 'ppa:chris-lea/redis-server':
        before => Anchor['redis::repo'],
      }
    }
  }

  # anchor resource provides a consistent dependency for prerequisites.
  anchor { 'redis::repo': }

  package { $packages: ensure => $version,
    require => Anchor['redis::repo']
  }
  ->
  Sredis <| title == stop |>

  exec {"update-rc.d -f redis-server remove":
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package[$packages],
  }
  ->
  file {"/etc/init/redis-server.conf":
    source => "puppet:///modules/redis/redis-server.conf",
  }
}
