#!/bin/bash

KANATA_PATH=/Applications/kanata

if [ -z "$KANATA_PATH" ]; then
  echo "Error: kanata not found in PATH."
  exit 1
fi

# Find all macos*.kbd files in the current directory
CONFIG_FILES=($(ls macos*.kbd 2>/dev/null))
if [ ${#CONFIG_FILES[@]} -eq 0 ]; then
  echo "Error: No macos*.kbd files found in the current directory."
  exit 1
fi


OUTPUT_FILE="/Library/LaunchDaemons/com.$USER.kanata.plist"

# Generate the launchctl service file output
echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
echo -e "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
echo -e "<plist version=\"1.0\">"
echo -e "<dict>"
echo -e "\t<key>Label</key>"
echo -e "\t<string>com.$USER.kanata</string>"
echo -e ""
echo -e "\t<key>ProgramArguments</key>"
echo -e "\t<array>"
echo -e "\t\t<string>$KANATA_PATH</string>"

# Build config arguments
PWD="$(pwd)"
for CONFIG in "${CONFIG_FILES[@]}"; do
  echo -e "\t\t<string>-c</string>"
  echo -e "\t\t<string>$PWD/$CONFIG</string>"
done

echo -e "\t</array>"
echo -e ""
echo -e "\t<key>RunAtLoad</key>"
echo -e "\t<true/>"
echo -e ""
echo -e "\t<key>KeepAlive</key>"
echo -e "\t<true/>"
echo -e ""
echo -e "\t<key>ProcessType</key>"
echo -e "\t<string>Interactive</string>"
echo -e ""
echo -e "\t<key>StandardOutPath</key>"
echo -e "\t<string>$HOME/Library/Logs/kanata.out.log</string>"
echo -e ""
echo -e "\t<key>StandardErrorPath</key>"
echo -e "\t<string>$HOME/Library/Logs/kanata.err.log</string>"
echo -e "</dict>"
echo -e "</plist>"
