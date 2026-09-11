#!/bin/sh
set -eu

: "${PAF_UPLOAD_DIR:=/data/uploads}"
: "${PAF_SRT_LISTEN_ADDRESS:=0.0.0.0}"
: "${PAF_SRT_PORT:=8000}"
: "${PAF_S3_IMPORT_SCRIPT:=/usr/local/bin/paf-s3-import-disabled}"
: "${PAF_NODE_SERIAL_NUMBER:=}"
PAF_DATABASE_READ_URL="${DATABASE_READ_URL:-${DATABASE_URL:-${DATABASE_WRITE_URL:-}}}"

mkdir -p "$PAF_UPLOAD_DIR"

cat > /etc/pafserver.conf <<EOF
basedir: $PAF_UPLOAD_DIR
ipaddress: $PAF_SRT_LISTEN_ADDRESS
port: $PAF_SRT_PORT
s3importscript: $PAF_S3_IMPORT_SCRIPT
nodeserialnumber: $PAF_NODE_SERIAL_NUMBER
databasereadurl: $PAF_DATABASE_READ_URL
EOF

exec "$@"
