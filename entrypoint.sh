#!/usr/bin/env bash

set -e

ensure_key() {
	local keyfile
	local keytype
	keytype="$1"
	keyfile="$TMATE_KEYS_DIR/ssh_host_${keytype}_key"
	if [ ! -f "$keyfile" ]; then
		ssh-keygen -t "$keytype" -E md5 -f "$keyfile" -N ''
	fi
}

if [ ! -d "$TMATE_KEYS_DIR" ]; then
	mkdir -p "$TMATE_KEYS_DIR"
fi

ensure_key rsa
ensure_key ecdsa

exec "$@"
