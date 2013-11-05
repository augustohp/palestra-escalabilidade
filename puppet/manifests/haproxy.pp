# HAProxy configuration

class { "haproxy":
    source_dir => "/vagrant/.puppet/files/etc/haproxy/conf"
}