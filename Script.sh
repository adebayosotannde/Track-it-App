#!/bin/sh

#  Script.sh
#  Track it Package Tracker
#
#  Created by Adebayo Sotannde on 9/22/22.
#



if which swiftlint >/dev/null; then
  swiftlint
  echo "Swift lint installed"
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
