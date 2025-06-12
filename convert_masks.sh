#!/bin/bash

# Usage: ./convert_masks.sh /path/to/input_dir /path/to/output_dir

INPUT_DIR="$1"
OUTPUT_DIR="$2"

if [[ -z "$INPUT_DIR" || -z "$OUTPUT_DIR" ]]; then
  echo "Usage: $0 /path/to/input_dir /path/to/output_dir"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

for FILE in "$INPUT_DIR"/*.png; do
  BASENAME=$(basename "$FILE")
  OUTPUT_FILE="$OUTPUT_DIR/$BASENAME"

  # Convert 255 to 1, leave 0 unchanged
  convert "$FILE" -depth 8 -type Grayscale \
    -fx 'i==255 ? 1 : 0' "$OUTPUT_FILE"
done

echo "Conversion complete. Output saved in $OUTPUT_DIR."
