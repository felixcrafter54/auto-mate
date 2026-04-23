#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BUILD_DIR="build/linux/x64/debug/bundle"

# Build if binary doesn't exist yet
if [ ! -f "$BUILD_DIR/auto_mate" ]; then
  echo "Building AutoMate for Linux..."
  flutter build linux --debug
fi

echo "Starting AutoMate..."
"$BUILD_DIR/auto_mate"
