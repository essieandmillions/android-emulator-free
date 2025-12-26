#!/bin/bash
set -e

echo "🚀 Setting up Android Emulator..."

# Install required packages
sudo apt-get update
sudo apt-get install -y curl git

# Pull and run Redroid (Android 12 in Docker)
echo "📱 Starting Redroid Android container..."
docker run -itd --rm --privileged \
  --name android \
  -p 5555:5555 \
  redroid/redroid:12.0.0-latest \
  ro.product.cpu.abilist=x86_64,arm64-v8a \
  ro.product.cpu.abilist64=x86_64,arm64-v8a

# Wait for Android to boot
echo "⏳ Waiting for Android to boot (30 seconds)..."
sleep 30

# Install noVNC for web access
echo "🌐 Setting up web interface..."
docker run -d --name novnc \
  -p 6080:6080 \
  --link android:android \
  -e DISPLAY_NUM=99 \
  -e VNC_PORT=5900 \
  geek1011/easy-novnc \
  --addr :6080 \
  --host localhost \
  --port 5900 \
  --no-url-password

echo "✅ Setup complete!"
echo ""
echo "🎉 Android Emulator is ready!"
echo "📱 Access it via the PORTS tab -> click on 6080"
echo "🔌 ADB port: 5555"
