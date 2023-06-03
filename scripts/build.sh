#!/bin/sh
VERSION=0.0.2

set -eo pipefail

curl -sSL --fail -O "https://github.com/nabeken/cloudwatchdoggo/releases/download/v${VERSION}/cloudwatchdoggo_${VERSION}_linux_amd64.zip"
curl -sSL --fail "https://github.com/nabeken/cloudwatchdoggo/releases/download/v${VERSION}/checksums.txt" | shasum --check --ignore-missing
