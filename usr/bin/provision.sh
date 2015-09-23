#!/usr/bin/env bash
#
# vim: noexpandtab ts=4 sw=4 ft=sh:

#DEBUG=1
set -e
[[ -z "$DEBUG" ]] || { set -x; }

declare -r VM_PROVISION_SCRIPT=$1
declare -r VM_IP=$2
declare -r VM_HOSTNAME=$3
declare -r VM_DOCUMENT_ROOT=$4

declare -r VAPROBASH_REPO=augustohp/Vaprobash
declare -r VAPROBASH_TREE=master
declare -r VAPROBRASH_BASE_BLOB_URL=https://raw.githubusercontent.com/$VAPROBASH_REPO/$VAPROBASH_TREE

declare -r BASE_PROVISIONING_FILE=$VAPROBRASH_BASE_BLOB_URL/scripts/base.sh
declare -r DOWNLOADED_SCRIPTS=/tmp/vaprobash
declare -r SWAP_SIZE=256 #MB


function download_file {
	[[ -z "$1" ]] && { echo "!!! File is required to download."; exit 1; }
	file_url="$VAPROBRASH_BASE_BLOB_URL/$1"
	destination_file="$DOWNLOADED_SCRIPTS/$1"
	destination_dir=`dirname $destination_file`
	[[ -f "$destination_dir" ]] || { mkdir -p $destination_dir; }

	wget --output-document $destination_file --quiet $file_url
	chmod a+x $destination_file
}

function download_and_execute {
	script=$1
	full_script_path="$DOWNLOADED_SCRIPTS/$script"
	shift
	download_file $script
	$full_script_path $*
}

function print_usage {
	cat <<-EOT
	Usage: $0 <SCRIPT> <IP> <HOSTNAME> <DOCUMENT ROOT>

	  SCRIPT        Name of script being used for provisioning.
	                Can be any inside 'usr/bin' directory.

	  IP            IPV4 address of the virtual machine.

	  HOSTNAME      Full hostname (with domain) of the virtual
	                machine (e.g: www.pascutti.localhost).

	  DOCUMENT ROOT Full directory path, inside virtual machine,
	                which has application code.
EOT
}

[[ -z "$VM_PROVISION_SCRIPT" ]] && { echo "!!! Provisioning script not given."; print_usage; exit 1; }
[[ -z "$VM_IP" ]] && { echo "!!! VM ip not given."; print_usage; exit 1; }
[[ -z "$VM_HOSTNAME" ]] && { echo "!!! VM full hostname not given."; print_usage; exit 1; }
[[ -z "$VM_DOCUMENT_ROOT" ]] && { echo "!!! Document root not given."; print_usage; exit 1; }

[[ -f "$DOWNLOADED_SCRIPTS" ]] && { mkdir -p "$DOWNLOADED_SCRIPTS"; }

download_and_execute "scripts/base.sh" $VAPROBRASH_BASE_BLOB_URL $SWAP_SIZE
vm_script_path=/vagrant/usr/bin/$VM_PROVISION_SCRIPT
chmod a+x $vm_script_path
source $vm_script_path
