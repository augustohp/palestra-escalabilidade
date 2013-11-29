import 'shared.pp'

class {'varnish':
  varnish_listen_port => 80,
  varnish_storage_size => '10M',
}

class { 'varnish::vcl':
  probes => [
    { name => 'health_check', url => "/health", timeout => "3s", interval => "10s" },
  ],
  backends => [
    { name => 'web1', host => '192.168.42.20', port => '80', probe => 'health_check' },
    { name => 'web2', host => '192.168.42.21', port => '80', probe => 'health_check' },
  ],
  directors => [
    { name => 'cluster', type => 'round-robin', backends => [ 'web1', 'web2' ] }
  ],
  selectors => [
    { backend => 'cluster' },
  ],
}
