#!/bin/bash

mkdir $DEPLOY_DIRECTORY

swift package resolve
swift test -c debug --enable-code-coverage
cp $(swift test --show-codecov-path) deploy/codecov.json
