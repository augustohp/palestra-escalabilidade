import 'shared.pp'

package { 'varnish':
    ensure => 'present'
}

file { '/etc/default/varnish':
    ensure => 'present',
    source => '/vagrant/puppet/files/etc/default/varnish',
    require => [Package['varnish']]
}

file { '/etc/varnish/default.vcl':
    ensure => 'present',
    source => '/vagrant/puppet/files/etc/varnish/default.vcl',
    require => [Package['varnish'], File['/etc/default/varnish']]
}

service { 'varnish':
    ensure => 'running',
    require => [Package['varnish'], File['/etc/default/varnish'], File['/etc/varnish/default.vcl']],
    subscribe =>[File['/etc/default/varnish'], File['/etc/varnish/default.vcl']]
}
