#!/bin/bash
set -euo pipefail

SDK_ROOT="/opt/android-sdk"
AVD_HOME="$HOME/.android/avd"
SDK_GROUP="android-sdk"
API_LEVEL="36"
BUILD_TOOLS_VERSION="36.0.0"
SYSTEM_IMAGE="system-images;android-${API_LEVEL};google_apis;x86_64"
AVD_NAME="Pixel_API_${API_LEVEL}"
SDKMANAGER="$SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"
AVDMANAGER="$SDK_ROOT/cmdline-tools/latest/bin/avdmanager"

yay -S --noconfirm --needed \
  android-sdk-cmdline-tools-latest \
  android-sdk-platform-tools \
  android-emulator \
  jdk-openjdk \
  acl

if ! getent group "$SDK_GROUP" >/dev/null; then
  sudo groupadd "$SDK_GROUP"
fi

if ! id -nG "$USER" | grep -qw "$SDK_GROUP"; then
  sudo usermod -aG "$SDK_GROUP" "$USER"
  echo "Added $USER to $SDK_GROUP. Log out and back in after this install for SDK write access."
fi

sudo mkdir -p "$SDK_ROOT"
sudo setfacl -R -m "u:${USER}:rwx" "$SDK_ROOT"
sudo setfacl -R -m "g:${SDK_GROUP}:rwx" "$SDK_ROOT"
sudo setfacl -d -m "u:${USER}:rwX" "$SDK_ROOT"
sudo setfacl -d -m "g:${SDK_GROUP}:rwX" "$SDK_ROOT"

sudo tee /etc/profile.d/android-sdk.sh >/dev/null <<EOF
export ANDROID_HOME="$SDK_ROOT"
export ANDROID_SDK_ROOT="$SDK_ROOT"
export ANDROID_AVD_HOME="\$HOME/.android/avd"
export PATH="\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/emulator:\$ANDROID_HOME/platform-tools:\$PATH"
EOF

export ANDROID_HOME="$SDK_ROOT"
export ANDROID_SDK_ROOT="$SDK_ROOT"
export ANDROID_AVD_HOME="$AVD_HOME"
export PATH="$SDK_ROOT/cmdline-tools/latest/bin:$SDK_ROOT/emulator:$SDK_ROOT/platform-tools:$PATH"
mkdir -p "$ANDROID_AVD_HOME"

if [ ! -x "$SDKMANAGER" ]; then
  echo "sdkmanager was not found after installing Android command line tools."
  echo "Expected it at $SDKMANAGER."
  exit 1
fi

if [ ! -x "$AVDMANAGER" ]; then
  echo "avdmanager was not found after installing Android command line tools."
  echo "Expected it at $AVDMANAGER."
  exit 1
fi

set +o pipefail
yes | "$SDKMANAGER" --sdk_root="$SDK_ROOT" --licenses
set -o pipefail
"$SDKMANAGER" --sdk_root="$SDK_ROOT" \
  "platform-tools" \
  "emulator" \
  "platforms;android-${API_LEVEL}" \
  "build-tools;${BUILD_TOOLS_VERSION}" \
  "$SYSTEM_IMAGE"

if [ ! -f "$ANDROID_AVD_HOME/${AVD_NAME}.ini" ]; then
  DEVICE_ID="$("$AVDMANAGER" list device | awk -F'"' '/id: .*"pixel_/ { print $2; exit }')"

  if [ -n "$DEVICE_ID" ]; then
    "$AVDMANAGER" create avd --force --name "$AVD_NAME" --package "$SYSTEM_IMAGE" --device "$DEVICE_ID"
  else
    echo "no" | "$AVDMANAGER" create avd --force --name "$AVD_NAME" --package "$SYSTEM_IMAGE"
  fi
else
  echo "AVD already exists: $AVD_NAME"
fi

if [ -e /dev/kvm ] && ! id -nG "$USER" | grep -qw kvm; then
  sudo usermod -aG kvm "$USER"
  echo "Added $USER to kvm. Log out and back in before starting the emulator for hardware acceleration."
fi

echo "Android API ${API_LEVEL} emulator installed."
echo "Available AVDs:"
emulator -list-avds
echo "Start it with: emulator @$AVD_NAME"
