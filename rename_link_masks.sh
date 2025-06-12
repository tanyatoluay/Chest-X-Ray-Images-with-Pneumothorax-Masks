#!/bin/bash

# Usage: ./organize_images.sh /path/to/source_dir

SOURCE_DIR="$1"

if [[ -z "$SOURCE_DIR" || ! -d "$SOURCE_DIR" ]]; then
  echo "Usage: $0 /path/to/source_dir"
  exit 1
fi

# Create output directories
mkdir -p labelsTr labelsTs

# Process files
for FILE in "$SOURCE_DIR"/*.png; do
  BASENAME=$(basename "$FILE")
  
  if [[ "$BASENAME" == *_train_* ]]; then
    DEST="labelsTr"
  elif [[ "$BASENAME" == *_test_* ]]; then
    DEST="labelsTs"
  else
    continue  # Skip files that don't match pattern
  fi

  # Remove the .png extension and add _0000
  NEW_NAME="${BASENAME%.png}.png"

  # Create symbolic link
  ln -s "$(realpath "$FILE")" "$DEST/$NEW_NAME"
done

echo "Symbolic links created in labelsTr and labelsTs."
