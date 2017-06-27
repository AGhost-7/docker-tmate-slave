#!/usr/bin/env bash

tmate-slave-run() {
	tmate-slave -k "$TMATE_KEYS_DIR" -p "$TMATE_PORT" "$@"
}

if [ ! -z "$TMATE_HOST" ]; then
	tmate-slave-run -h "$TMATE_HOST"
else
	tmate-slave-run
fi

