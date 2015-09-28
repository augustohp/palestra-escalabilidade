#!/usr/bin/env bash
#
# Provisions HAProxy as well as its configuration
# for handling multiple backends.
#
# vim: noexpandtab ts=4 sw=4 ft=sh:

declare -r HAPROXY_CONFIG=/etc/haproxy/haproxy.cfg
declare -r HAPROXY_CONFIG_ORIGINAL=${HAPROXY_CONFIG}.bkp

echo ">>> Installing HAProxy ..."
sudo apt-get update -qq
sudo apt-get install -qq -y haproxy

sed -i -e 's/ENABLED=0/ENABLED=1/g' /etc/default/haproxy

if [ -z "$(cat $HAPROXY_CONFIG | grep backend)" ]; then
	cat <<-EOT >> $HAPROXY_CONFIG
	frontend site
	        bind *:80
	        mode http
	        default_backend www

	backend www
           mode http
           balance roundrobin
           option forwardfor
           server www1 192.168.42.20:80 check inter 2000 maxconn 2048
           server www2 192.168.42.21:80 check inter 2000 maxconn 2048
	EOT
fi

sudo service haproxy restart
