#!/usr/bin/env bash
set -euo pipefail

test "${VERBOSE:-}" && set -x

# Publish a release on forgejo

main()
{
  : "${OWNER:=${FORGEJO_REPOSITORY%%/*}}"
  : "${REPO:=${FORGEJO_REPOSITORY##*/}}"
  : "${SERVER_URL:=${FORGEJO_SERVER_URL}}"
  : "${SHA:=${FORGEJO_SHA}}"
  : "${TAG:=${FORGEJO_REF_NAME}}"
  : "${TOKEN:=${FORGEJO_TOKEN}}"
  : "${WORKSPACE:=${FORGEJO_WORKSPACE}}"

  : "${IS_DRAFT:-}"
  : "${IS_PRERELEASE:-}"

  if [[ "${TAG}" =~ test$ ]]; then
    IS_DRAFT=true
  fi

  verify_tag
  publish_release
  verify_release
}

# Make sure the tag passed to the job matches the tag in the repo
verify_tag()
{
  local sha endpoint

  endpoint=$(printf "repos/%s/%s/tags/%s" "${OWNER}" "${REPO}" "${TAG}")
  sha=$(api GET "${endpoint}" | jq --raw-output .commit.sha)

  test "${FORGEJO_SHA}" = "${sha}"
}

# Create the release
publish_release()
{
  local endpoint name request_body
  name="${TAG}"
  endpoint=$(printf "repos/%s/%s/releases" "${OWNER}" "${REPO}")
  release_notes_file=$(
    printf "%s/docs/release-notes/%s.md" \
    "${WORKSPACE}" "${TAG}"
  )

  test -f "${release_notes_file}" \
    && release_notes=$(jq -sRr @uri < "${release_notes_file}")

  request_body=$(
    jq --null-input \
    --arg name "${name}" \
    --arg tag_name "${TAG}" \
    --arg body "${release_notes}" \
    '$ARGS.named'
  )

  test "${IS_DRAFT}" && request_body=$(
      echo "${request_body}" \
      | jq --arg draft "true" '. += $ARGS.named'
    )

  test "${IS_PRERELEASE}" && request_body=$(
    echo "${request_body}" \
    | jq --arg prerelease "true" '. += $ARGS.named'
  )

  api POST "${endpoint}" "${request_body}"
}

# Verify release
verify_release()
{
  local endpoint
  endpoint=$(printf "repos/%s/%s/releases/%s" "${OWNER}" "${REPO}" "${TAG}")

  api GET "${endpoint}"
}

# Ensure an env var exists and is set
check_env()
{
  if test -z "$1"; then
    echo "Required variables $1 isn't set. Exiting"
    exit
  fi
}

# Helper function for hitting APIs
api() {
    method=$1
    shift
    path=$1
    shift

    local uri

    uri=$(printf "%s/api/v1/%s" "${SERVER_URL}" "${path}")
    curl --fail \
      -X "${method}" -sS \
      -H "Content-Type: application/json" \
      -H "Authorization: token ${TOKEN}" \
      "$@" "${uri}"
}

main "$@"
