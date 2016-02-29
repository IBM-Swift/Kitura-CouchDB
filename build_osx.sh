#!/bin/bash

##
# Copyright IBM Corporation 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##

# This script builds the Kitura sample app on OS X (Travis CI).
# Homebrew (http://brew.sh/) must be installed on the OS X system for this
# script to work.

# If any commands fail, we want the shell script to exit immediately.
set -e

# Variables
SWIFT_SNAPSHOT=swift-DEVELOPMENT-SNAPSHOT-2016-02-25-a

# Install system level dependencies for Kitura
brew update
brew install http-parser pcre2 curl hiredis swiftlint
brew install wget || brew outdated wget || brew upgrade wget

# Install Swift binaries
# See http://apple.stackexchange.com/questions/72226/installing-pkg-with-terminal
wget https://swift.org/builds/development/xcode/$SWIFT_SNAPSHOT/$SWIFT_SNAPSHOT-osx.pkg
sudo installer -pkg $SWIFT_SNAPSHOT-osx.pkg -target /
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"

# Run SwiftLint to ensure Swift style and conventions
# swiftlint

# Build Kitura-CouchDB
echo ">> About to build Kitura-CouchDB..."
swift build -Xcc -fblocks -Xswiftc -I/usr/local/include -Xlinker -L/usr/local/lib

# Work in progress...
# Execute test cases for Kitura-CouchDB
#echo ">> About to execute test cases for Kitura..."
#swift test
#echo ">> Execution of test cases completed (see above for results)."
