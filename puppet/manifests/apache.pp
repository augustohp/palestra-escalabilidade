$www_owner = 'www-data'
$www_owner_group = 'www-data'

package { ['lynx','git-core','make']:
  ensure  => present,
}

class { "apache":  }

#apache::dotconf { 'custom':
#  content => 'EnableSendfile Off',
#}

apache::module { 'rewrite': }
apache::module { 'status': }
apache::module { 'php5': }

apache::vhost { "${fqdn}":
  source => "/vagrant/puppet/files/etc/apache2/default-site",
  template => '',
  priority => 0
}
