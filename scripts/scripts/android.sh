#!/bin/bash

# --- CONFIGURATION ---
# Auto-detect package and main activity
PACKAGE_NAME=$(grep "applicationId" app/build.gradle* | head -n 1 | cut -d'"' -f2)
# If your main activity isn't .MainActivity, change it here:
ACTIVITY=".MainActivity"

echo "⚡ Starting Fast Build for $PACKAGE_NAME..."

# 1. Try Offline Build First
# We use the variable here in the 'am start' command
if ./gradlew installDebug --offline --parallel -x lint -x test -x check && adb shell am start -n "$PACKAGE_NAME/$ACTIVITY"; then
  echo "✅ Build Successful (Offline)"
else
  echo "⚠️  Offline build failed. Attempting Online Sync..."

  # 2. Fallback to Online Build (Only if offline fails)
  # Updated here as well
  ./gradlew installDebug --parallel -x lint -x test -x check && adb shell am start -n "$PACKAGE_NAME/$ACTIVITY"
fi

# 3. Launch Message
echo "📱 App $PACKAGE_NAME is ready!"
