# Setting up Civix on a new machine

From nothing to the app running on an Android emulator. Every step here was
run end to end on macOS 26 / Apple Silicon; where another platform differs,
it's marked — those variants are reasoned from the tooling's own docs, not
verified on hardware.

The app needs **no backend, no API key, and no account** to run. It falls
back to two bundled sample briefs in `civix_app/assets/sample_briefs/`, so a
fresh clone is immediately usable offline. The `ANTHROPIC_API_KEY` in the
pipeline section is only for drafting *new* briefs.

## 0. Budget the disk first

The Android toolchain needs roughly **20 GB**: SDK + emulator image ~9 GB,
Gradle caches ~5 GB, the AVD ~4 GB, and build output ~2 GB. Check before you
start, because the emulator fails in a confusing way when it runs short — it
reports a userdata partition it can't allocate, not "disk full":

```
df -h /
```

## 1. Flutter

```
brew install --cask flutter     # macOS; elsewhere see flutter.dev/setup
flutter --version               # this repo was built against 3.47.2
```

## 2. Java

`sdkmanager` is a Java program, so a JDK has to be on `PATH` before the
Android SDK will install. Any JDK 17+ works.

```
java -version || brew install --cask temurin
```

## 3. Android SDK

Android Studio works, but the command-line tools are much smaller and
sufficient:

```
brew install --cask android-commandlinetools
export ANDROID_HOME=/opt/homebrew/share/android-commandlinetools   # Intel Macs: /usr/local/share/...
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0" \
           "emulator" "system-images;android-36;google_apis;arm64-v8a"
flutter config --android-sdk "$ANDROID_HOME"
```

API 36 is not arbitrary — it's what Flutter 3.47's Gradle plugin defaults
`compileSdk` and `targetSdk` to. If you upgrade Flutter, check
`packages/flutter_tools/gradle/src/main/kotlin/FlutterExtension.kt` and match
the image to it.

**On Intel** (Mac or Linux) swap the image ABI to `x86_64`:
`system-images;android-36;google_apis;x86_64`.

## 4. Create the emulator

```
avdmanager create avd -n civix -k "system-images;android-36;google_apis;arm64-v8a" -d pixel_7
```

A `Could not load devices from .../devices.xml` warning here is harmless —
the Pixel 7 profile still applies. Confirm with `avdmanager list avd`.

The AVD defaults to a **10 GB** data partition, which needs ~12 GB free to
boot. If you're tight on space, edit `~/.android/avd/civix.avd/config.ini`:

```
disk.dataPartition.size=3G
sdcard.size=128 MB
```

3 GB is plenty for this app and boots in a few seconds once warm.

## 5. Build and run

From the repo root:

```
./run
```

That's the whole thing. It boots the emulator if it isn't already up, waits
for it to finish booting (the part that's easy to get wrong by hand), fetches
packages and runs codegen on a fresh clone, then starts the app. Press `r` to
hot reload, `q` to quit.

`./run` passes any extra arguments straight through to `flutter run`, so
`./run --release` and `./run -d macos` both work; giving it an explicit `-d`
skips the emulator handling entirely.

To run the tests, or to do the steps by hand:

```
cd civix_app
flutter pub get
dart run build_runner build          # generates *.g.dart / *.freezed.dart
flutter test                         # 35 tests, all should pass
```

To point a build at a real published feed instead of the bundled samples:

```
flutter run --dart-define=CIVIX_CDN_BASE_URL=https://your-cdn/briefs
```

## iOS / macOS instead of Android

The `macos/` Runner is configured with the right sandbox entitlements, so
once **full Xcode** is installed (Command Line Tools alone is not enough):

```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
flutter run -d macos
```

Xcode is a ~15 GB download on top of the budget above. This path is set up
but has not been run here.

## Why the web target is not an option

`flutter run -d chrome` will not work without real source changes.
`lib/data/local/database.dart` uses `path_provider` and
`lib/data/local/notifications.dart` uses `flutter_local_notifications`;
neither supports web, and Drift would need its WASM backend plus a worker
setup. That's a port, not a flag.

## The pipeline

Independent of the app — you don't need it to run the client.

```
cd civix_pipeline
python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
.venv/bin/pytest                     # gate + model tests, no API key needed
```

Only drafting new briefs needs credentials:

```
export ANTHROPIC_API_KEY=...
.venv/bin/uvicorn civix.review.app:app --reload    # review UI on :8000
```

## Troubleshooting

**`Cannot lock execution history cache ... already been locked`** — a Gradle
daemon died badly and left a stale lock:

```
pkill -f GradleDaemon
rm -rf civix_app/android/.gradle
```

**`Dependency ':flutter_local_notifications' requires core library
desugaring`** — already fixed in `android/app/build.gradle.kts`
(`isCoreLibraryDesugaringEnabled` plus the `desugar_jdk_libs` dependency). If
you see it, you're on a tree predating that change.

**Emulator won't boot / no device in `adb devices`** — check the log the run
script writes to `/tmp/civix-emulator.log`. A `FATAL` line about the userdata
partition means disk space; see step 4.

**`flutter test` hangs on a widget test** — screens that fetch a brief sit on
a `CircularProgressIndicator` whose animation never ends, so `pumpAndSettle`
times out instead of failing usefully. Override `todayBriefProvider` and
`archiveProvider` in the test, as `test/app/nav_bar_test.dart` does.
