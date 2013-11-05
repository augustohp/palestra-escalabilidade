$tld = 'acasa.dev'
$zone = "${tld}."

class { 'bind': }

bind::zone { "${tld}":
  zone_serial => 1,
  zone_ttl => '3600000',
  zone_contact => "root.${zone}",
  zone_refresh   => '604800',
  zone_retry     => '86400',
  zone_expire    => '2419200',
  zone_neg_cache => '604800',
  zone_ns => "ns1.${zone}",
  zone_name => "${tld}"
}

bind::ns { "ns1.${zone}":
  zone => "${tld}"
}

bind::a { "ns1.${zone}":
   zone   => "${tld}",
   target => '192.168.42.254',
}

bind::a { "www.${zone}":
   zone   => "${tld}",
   target => '192.168.42.81',
}