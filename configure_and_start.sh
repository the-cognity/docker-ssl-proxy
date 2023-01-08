#!/bin/sh -e

echo 'here1'
export SERVER_NAME=${SERVER_NAME:-localhost}
echo 'here2'
export TARGET_SCHEME=${TARGET_SCHEME:-http}
export TARGET_PORT=${TARGET_PORT:-80}
export TARGET_HOST=${TARGET_HOST:-proxyapp}
export TARGET_HOST_HEADER=${TARGET_HOST_HEADER:-${TARGET_HOST}}
export CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:-20M}
export SSL_PORT=${SSL_PORT:-443}

echo 'here6'
REPLACEABLE='$SERVER_NAME:$TARGET_SCHEME:$TARGET_PORT:$TARGET_HOST:$TARGET_HOST_HEADER:$CLIENT_MAX_BODY_SIZE:$SSL_PORT'

echo 'here8'
envsubst $REPLACEABLE </nginx.conf.template >/etc/nginx/nginx.conf

echo 'here100'

/add_self_signed_certs.sh

# Use exec so nginx can get signals directly
exec nginx
