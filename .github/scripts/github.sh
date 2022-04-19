#!/bin/bash

# Copied and modified from https://github.com/jeffreytse/jekyll-deploy-action/blob/1ce0b36aeb585140ed9d54247de31474d4ac7ea8/providers/github.sh

set -euo pipefail

: "${BRANCH:=gh-pages}"
: "${ACTOR:=${GITHUB_ACTOR}}"

# Check if deploy to same branch
if [[ "${REPOSITORY}" = "${GITHUB_REPOSITORY}" ]]; then
  if [[ "${GITHUB_REF}" = "refs/heads/${BRANCH}" ]]; then
    echo "It's conflicted to deploy on same branch ${BRANCH}"
    exit 1
  fi
fi

# Tell GitHub Pages not to run Jekyll
touch .nojekyll
if [[ -n "${INPUT_CNAME-}" ]]; then
	echo "$INPUT_CNAME" > CNAME
fi

echo "Deploying to ${REPOSITORY} on branch ${BRANCH}"
echo "Deploying to https://${ACTOR}:${TOKEN}@github.com/${REPOSITORY}.git"

REMOTE_REPO="https://${ACTOR}:${TOKEN}@github.com/${REPOSITORY}.git" && \
  git init && \
  git config user.name "${ACTOR}" && \
  git config user.email "${ACTOR}@users.noreply.github.com" && \
  git add . && \
  git commit -m "jekyll build from Action ${GITHUB_SHA}" && \
  git push --force "$REMOTE_REPO" "master:$BRANCH"

cd ..
