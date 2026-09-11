#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PAF2_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
IMAGE_NAME="${PAF_BUILD_IMAGE:-paf2-build-env:ubuntu24.04}"

docker build -f "$SCRIPT_DIR/Dockerfile.build-env" -t "$IMAGE_NAME" "$SCRIPT_DIR"

docker run --rm \
  -u "$(id -u):$(id -g)" \
  -v "$SCRIPT_DIR:/workspace/paf-server" \
  -v "$PAF2_DIR/paf2-client:/workspace/paf2-client" \
  -w /workspace \
  "$IMAGE_NAME" \
  sh -eu -c '
    mkdir -p paftransfer/obj paftransfer/bin
    cd /workspace/paf-server/paftransfer
    make DEBUG="" bin/pafserver

    cd /workspace/paf2-client
    mkdir -p obj bin
    ./build.sh
  '
