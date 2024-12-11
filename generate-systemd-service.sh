#!/bin/bash

KANATA_PATH=$(which kanata)

if [ -z "$KANATA_PATH" ]; then
  echo "Error: kanata not found in PATH."
  exit 1
fi

# Find all linux*.kbd files in the current directory
CONFIG_FILES=($(ls linux*.kbd 2>/dev/null))
if [ ${#CONFIG_FILES[@]} -eq 0 ]; then
  echo "Error: No linux*.kbd files found in the current directory."
  exit 1
fi

# Build config arguments
CONFIG_ARGS=""
PWD="$(pwd)"
for CONFIG in "${CONFIG_FILES[@]}"; do
  CONFIG_ARGS+="-c $PWD/$CONFIG "
done

OUTPUT_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/kanata.service"

# Generate the systemd service file output
echo "[Unit]" > $OUTPUT_FILE
echo "Description=Kanata keyboard remapper" >> $OUTPUT_FILE
echo "Documentation=https://github.com/jtroo/kanata" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
echo "[Service]" >> $OUTPUT_FILE
echo "Environment=DISPLAY=:0" >> $OUTPUT_FILE
echo "Type=simple" >> $OUTPUT_FILE
echo "ExecStart=$KANATA_PATH $CONFIG_ARGS" >> $OUTPUT_FILE
echo "Restart=no" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
echo "[Install]" >> $OUTPUT_FILE
echo "WantedBy=sysinit.target" >> $OUTPUT_FILE
