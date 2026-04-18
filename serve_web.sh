#!/bin/bash
set -e

echo "Building Flutter web (PWA)..."
flutter build web --pwa-strategy=offline-first

echo "Serving on http://localhost:8080"
cd build/web
python3 -m http.server 8080
