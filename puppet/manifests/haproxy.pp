# HAProxy configuration

package { ['haproxy']:
  ensure  => present,
}

file { "/etc/haproxy/haproxy.cfg":
    ensure => present,
    source => "/vagrant/puppet/files/etc/haproxy/haproxy.cfg",
    owner => "root",
    group => "root"
}

file { "/etc/default/haproxy":
    ensure => present,
    source => "/vagrant/puppet/files/etc/default/haproxy",
    owner => "root",
    group => "root"
}

service { "haproxy":
    ensure => "running",
    require => [Package["haproxy"]],
    subscribe => [
        File["/etc/haproxy/haproxy.cfg"],
        File["/etc/default/haproxy"]
    ]
}
