#!/usr/bin/env bash

VERSIONS_FILE=versions.json
LATEST_VERSION=$1

CURRENT_VERSION=$(jq -r '.latest' "${VERSIONS_FILE}")

function ver {
  printf "%03d%03d%03d" $(echo "$1" | tr '.' ' ');
}

if [ -z "${LATEST_VERSION}" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

if [ "$(ver "${LATEST_VERSION}")" -le "$(ver "${CURRENT_VERSION}")" ]; then
  echo "Version must be greater than ${CURRENT_VERSION}"
  exit 2
fi

LATEST_VERSIONS=$(jq --arg version "${LATEST_VERSION}" '.latest |= $version' "${VERSIONS_FILE}")

echo "${LATEST_VERSIONS}" > "${VERSIONS_FILE}"

echo "Bump latest version from ${CURRENT_VERSION} to ${LATEST_VERSION}"
