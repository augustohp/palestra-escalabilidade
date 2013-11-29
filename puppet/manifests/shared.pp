class { 'apt':
    always_apt_update => true
}

group { "puppet":
    ensure => present
}

Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', 'usr/local/bin']
}

exec {'apt-get update':
    command => "apt-get update"
}

package { ["vim", "tree", "curl", "gnuplot"]:
    ensure => present,
    require => Exec['apt-get update']
}

file { "/etc/default/environment":
    ensure => present,
    source => "/vagrant/puppet/files/etc/default/environment"
}

file { "/etc/resolvconf/resolv.conf.d/tail":
    ensure => present,
    source => "/vagrant/puppet/files/etc/resolv.conf"
}

file { "/etc/timezone":
    ensure => present,
    source => "/vagrant/puppet/files/etc/timezone"
}

exec { 'tz-reconfigure':
    command => 'dpkg-reconfigure --frontend noninteractive tzdata',
    require => File['/etc/timezone'],
    user => "root",
    group => "root"
}

class { '::ntp':
    servers => [
        "0.south-america.pool.ntp.org",
        "1.south-america.pool.ntp.org",
        "2.south-america.pool.ntp.org",
        "3.south-america.pool.ntp.org"
    ]
}

include build_essential
