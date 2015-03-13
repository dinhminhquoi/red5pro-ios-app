#!/bin/sh

BUILD_COMMAND=$(which xctool || which xcodebuild)
$BUILD_COMMAND -project Red5Pro.xcodeproj -scheme Red5ProiOS
