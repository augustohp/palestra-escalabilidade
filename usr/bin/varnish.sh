#!/usr/bin/env bash
#
# Provisions PHP 5.6 with PHP-FPM and NGINX on port 80
# This has to be used together through `provision.sh`
# which uses a custom Vaprobash repository.
#
# vim: noexpandtab ts=4 sw=4 ft=sh:

declare -r VARNISH_CONFIG=/etc/varnish/default.vcl
declare -r VARNISH_DEFAULT_CONFIG=/etc/default/varnish
declare -r VARNISH_MALLOC_SIZE=16m

echo ">>> Installing Varnish..."
sudo apt-get install -qq -y apt-transport-https
curl --silent https://repo.varnish-cache.org/ubuntu/GPG-key.txt | sudo apt-key add -
sudo sh -c 'echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list'
apt-get update -qq
sudo apt-get install -qq -y varnish

sed -i -e 's/-a :6081/-a :80/g' $VARNISH_DEFAULT_CONFIG
sed -i -e "s/malloc,256m/malloc,$VARNISH_MALLOC_SIZE/g" $VARNISH_DEFAULT_CONFIG


sed -i -e 's/\.host = "127.0.0.1";/\.host = "192.168.42.2";/g' $VARNISH_CONFIG
sed -i -e 's/\.port = "8080";/\.port = "80";/g' $VARNISH_CONFIG

sudo service varnish restart
