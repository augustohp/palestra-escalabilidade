#!/usr/bin/env bash
#
# Provisions PHP 5.6 with PHP-FPM and NGINX on port 80
# This has to be used together through `provision.sh`
# which uses a custom Vaprobash repository.
#
# vim: noexpandtab ts=4 sw=4 ft=sh:

declare -r WITHOUT_HHVM=false
declare -r WITH_HHVM=true

download_and_execute "scripts/php.sh" "America/Sao_Paulo" $WITHOUT_HHVM "5.6"
download_and_execute "scripts/nginx.sh" "$VM_IP" "$VM_DOCUMENT_ROOT" "$VM_HOSTNAME" "$VAPROBRASH_BASE_BLOB_URL"
