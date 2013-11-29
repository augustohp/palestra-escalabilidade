Class['::apt::update'] -> Package <|
    title != 'python-software-properties'
and title != 'software-properties-common'
|>
apt::key { '4F4EA0AAE5267A6C': }
apt::ppa { 'ppa:ondrej/php5':
  require => [Apt::Key['4F4EA0AAE5267A6C'], Exec['apt-get update']]
}

class { 'php':
  service             => 'apache',
  service_autorestart => false,
  module_prefix       => '',
}

php::module { 'php5-mysql': }
php::module { 'php5-cli': }
php::module { 'php5-common': }
php::module { 'php5-curl': }
php::module { 'php5-gd': }
php::module { 'php5-imagick': }
php::module { 'php5-intl': }
php::module { 'php5-mcrypt': }
php::module { 'php5-memcached': }
php::module { 'php5-sqlite': }
php::module { 'php5-readline': }
php::module { 'php-apc': }
php::module { 'php-gettext': }

class { 'php::pear':
  require => Class['php'],
}
