#!/bin/bash
VERSION=0.0.3

set -eo pipefail

T=$(mktemp -d)
trap "rm -rf ${T}" EXIT

pushd "${T}"

curl -sSL --fail -O "https://github.com/nabeken/cloudwatchdoggo/releases/download/v${VERSION}/cloudwatchdoggo_${VERSION}_linux_amd64.zip"
curl -sSL --fail "https://github.com/nabeken/cloudwatchdoggo/releases/download/v${VERSION}/checksums.txt" | shasum --check --ignore-missing

echo "renaming the binary to 'bootstrap'..."

unzip "cloudwatchdoggo_${VERSION}_linux_amd64.zip"
cp -a cloudwatchdoggo bootstrap
zip "cloudwatchdoggo_${VERSION}_linux_amd64.zip" bootstrap
zip "cloudwatchdoggo_${VERSION}_linux_amd64.zip" -d cloudwatchdoggo

popd

mv "${T}/cloudwatchdoggo_${VERSION}_linux_amd64.zip" .
