#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <app_path>"
    echo "  Example: $0 '/Applications/Install macOS 15 beta.app'"
    exit 1
fi

APP_PATH="$1"
DMG_PATH="$APP_PATH/Contents/SharedSupport/SharedSupport.dmg"
TARGET_FOLDER="com_apple_MobileAsset_MobileSoftwareUpdate_MacUpdateBrain"

# Function to display a progress indicator
show_progress() {
    echo -n "Searching Installer: "
    while kill -0 "$1" 2>/dev/null; do
        echo -n "."
        sleep 1
    done
    echo ""
}

# Mount the DMG file and show progress indicator
hdiutil attach "$DMG_PATH" > /dev/null 2>&1 &
PID=$!
show_progress $PID
wait $PID

# Check if the DMG file was mounted successfully
if ! hdiutil info | grep -q "/Volumes/Shared Support"; then
    echo "Failed to mount the DMG file."
    exit 1
fi

MOUNT_POINT=$(hdiutil info | grep "/Volumes/Shared Support" | awk '{print substr($0, index($0,$3))}')

# echo "Mounted Installer DMG at $MOUNT_POINT"

# Set the path to the target folder inside the mounted DMG
TARGET_PATH="$MOUNT_POINT/$TARGET_FOLDER"

# Check if the target path exists
if [ ! -d "$TARGET_PATH" ]; then
    echo "Target folder $TARGET_PATH not found."
    hdiutil detach "$MOUNT_POINT"
    exit 1
fi

# Find the build attribute using grep and sed
BUILD_VALUE=$(grep -r "Build" "$TARGET_PATH" | sed -n 's/.*"Build": *"\([^"]*\)".*/\1/p')

if [ -z "$BUILD_VALUE" ]; then
    echo "Unable to detect macOS Build Version, check the Contents/SharedSupport/SharedSupport.dmg folder for com_apple_MobileAsset_MobileSoftwareUpdate_MacUpdateBrain"
else
    echo "macOS Build: $BUILD_VALUE"
fi

# Unmount the DMG file
hdiutil detach -quiet "$MOUNT_POINT"

# echo "Unmounted DMG from $MOUNT_POINT"
