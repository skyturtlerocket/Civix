#!/usr/bin/env bash
# Boot the Civix emulator (if it isn't already up) and run the app on it.
#
# The Android SDK here is the Homebrew command-line-tools install, not an
# Android Studio one, so ANDROID_HOME has to be set explicitly -- Flutter
# reads it from its own config, but adb/emulator invoked directly do not.
set -euo pipefail

export ANDROID_HOME="${ANDROID_HOME:-/opt/homebrew/share/android-commandlinetools}"
ADB="$ANDROID_HOME/platform-tools/adb"
cd "$(dirname "$0")"

if [ "$("$ADB" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; then
  echo "Booting the civix emulator..."
  nohup "$ANDROID_HOME/emulator/emulator" -avd civix -no-boot-anim \
    >/tmp/civix-emulator.log 2>&1 &

  # First boot after a cold start takes ~30s; a warm snapshot is a few seconds.
  for _ in $(seq 1 60); do
    sleep 3
    [ "$("$ADB" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ] && break
  done
fi

if [ "$("$ADB" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; then
  echo "Emulator did not finish booting -- see /tmp/civix-emulator.log" >&2
  exit 1
fi

echo "Emulator ready. Starting Civix (press r to hot reload, q to quit)."
exec flutter run -d emulator-5554 "$@"
