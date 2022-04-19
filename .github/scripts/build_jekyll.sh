#!/bin/bash

# Copied and modified from https://github.com/jeffreytse/jekyll-deploy-action/blob/1ce0b36aeb585140ed9d54247de31474d4ac7ea8/entrypoint.sh

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
WORKING_DIR="${PWD}"

# Initial default value
: "${JEKYLL_SRC:=./}"
: "${JEKYLL_CFG:=./_config.yml}"
: "${JEKYLL_BASEURL:=}"

echo "Starting the Jekyll Deploy Action"

if [[ -z "${TOKEN-}" ]]; then
  echo "Please set the TOKEN environment variable."
  exit 1
fi

# Check parameters and assign default values
: "${REPOSITORY:=${GITHUB_REPOSITORY}}"

# Check if repository is available
if ! echo "${REPOSITORY}" | grep -Eq ".+/.+"; then
  echo "The repository ${REPOSITORY} doesn't match the pattern <author>/<repos>"
  exit 1
fi

# Fix Github API metadata warnings
export JEKYLL_GITHUB_TOKEN="${TOKEN}"

cd "${JEKYLL_SRC}"

# Pre-handle Jekyll baseurl
if [[ -n "${JEKYLL_BASEURL-}" ]]; then
  JEKYLL_BASEURL="--baseurl ${JEKYLL_BASEURL}"
fi

echo "Starting jekyll build"
JEKYLL_ENV=production bundle exec jekyll build \
  "${JEKYLL_BASEURL}" \
  -c "${JEKYLL_CFG}" \
  -d "${WORKING_DIR}/build"

cd "${WORKING_DIR}/build"

. "${SCRIPT_DIR}/github.sh"
