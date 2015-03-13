#/bin/sh

# Clean previous builds.
if [ -d dist ]; then
  rm -rf dist
fi

if [ -d build ]; then
  rm -rf build
fi

# Create build dirs.
mkdir dist
mkdir build

# Generate intermediate archive.
xcodebuild -configuration Release -scheme Red5ProiOS archive -archivePath build/archive/Red5ProiOS.xcarchive

# Generate IPA.
xcodebuild -configuration Release -exportArchive -exportFormat ipa -archivePath "build/archive/Red5ProiOS.xcarchive" -exportPath "dist/Red5Pro.ipa" -exportProvisioningProfile "$PROFILE_NAME"
