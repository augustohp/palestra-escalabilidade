$www_owner = 'vagrant'
$www_owner_group = 'vagrant'

package { "lynx": ensure => present }
package { ['lynx','git-core','make']:
  ensure  => present,
}


class { "apache":  }

apache::dotconf { 'custom':
  content => 'EnableSendfile Off',
}

apache::module { 'rewrite': }
apache::module { 'status': }

apache::vhost { "${fqdn}":
  server_name   => "${fqdn}",
  serveraliases => ["www.${fqdn}"],
  docroot       => '/var/www/public',
  docroot_owner => $www_owner,
  docroot_group => $www_owner_group,
  port          => '80',
  priority      => '1',
}