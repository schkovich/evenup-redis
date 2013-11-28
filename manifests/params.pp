class redis::params {
  $packages = $operatingsystem ? {
    /(?i-mx:ubuntu|debian)/        => 'redis-server',
    /(?i-mx:centos|fedora|redhat)/ => 'redis',
    default => fail("Unsupported osfamily: ${::osfamily} operatingsystem: 
      ${::operatingsystem}, module ${module_name} only support osfamily 
      RedHat and Debian"
    )
  } 
}