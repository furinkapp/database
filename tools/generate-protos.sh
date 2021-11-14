#!/usr/bin/env bash
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
  mkdir -p $(realpath "$SCRIPT_DIR/$OUT_DIR")
fi
# run protoc and compile
protoc \
    --plugin="protoc-gen-ts=$(realpath "$SCRIPT_DIR/$PROTOC_GEN_TS_PATH")" \
    --js_out="import_style=commonjs,binary:$(realpath "$SCRIPT_DIR/$OUT_DIR")" \
    --ts_out="$(realpath "$SCRIPT_DIR/$OUT_DIR")" \
	--proto_path $(realpath "$SCRIPT_DIR/$PROTO_DIR") \
    $(realpath "${SCRIPT_DIR}/${PROTO_DIR}/database.proto")
