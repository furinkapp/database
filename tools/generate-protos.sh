#!/usr/bin/env bash
set -euo pipefail
# Directory containing protoc-gen-ts plugin executable.
PROTOC_GEN_TS_PATH="../node_modules/.bin/protoc-gen-ts"
# Directory containing protocol files.
PROTO_DIR="../../proto"
# Directory to write generated code to (.js and .d.ts files).
OUT_DIR="../generated"

# resolve script directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# ensure output directory exists
if [ ! -d $(realpath "$SCRIPT_DIR/$OUT_DIR") ]; then
	echo info: creating output directory
  	mkdir -p $(realpath "$SCRIPT_DIR/$OUT_DIR")
fi
# remove old files
echo info: removing old files
rm -rf $(realpath "$SCRIPT_DIR/$OUT_DIR")/*
# run protoc and compile
echo info: compiling protobufs and generating types
protoc \
    --plugin="protoc-gen-ts=$(realpath "$SCRIPT_DIR/$PROTOC_GEN_TS_PATH")" \
    --js_out="import_style=commonjs,binary:$(realpath "$SCRIPT_DIR/$OUT_DIR")" \
    --ts_out="$(realpath "$SCRIPT_DIR/$OUT_DIR")" \
	--proto_path $(realpath "$SCRIPT_DIR/$PROTO_DIR") \
    $(realpath "${SCRIPT_DIR}/${PROTO_DIR}/database.proto")

echo info: done.