#!/usr/bin/env bash

musl-build() {
  if [ -n "$1" ]; then tag=":$1"; else tag=""; fi
  docker run \
    -v cargo-cache:/root/.cargo/registry \
    -v "$PWD:/volume" \
    --rm -it clux/muslrust$tag cargo build --release
}
