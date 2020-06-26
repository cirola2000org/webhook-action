#!/bin/sh
set -eu

WEBHOOK_DATA="\"repository\":\"$GITHUB_REPOSITORY\",\"ref\":\"$GITHUB_REF\",\"commit\":\"$GITHUB_SHA\",\"trigger\":\"$GITHUB_EVENT_NAME\",\"workflow\":\"$GITHUB_WORKFLOW\""
WEBHOOK_SIGNATURE=$(echo -n "${WEBHOOK_DATA}" | openssl sha1 -hmac "$webhook_secret" -binary | xxd -p)
WEBHOOK_ENDPOINT=$webhook_url
WEBHOOK_GUID="896668ab-8924-4196-9653-8aca50720d46"

echo "request to:"
echo $WEBHOOK_ENDPOINT
echo "data"
echo $WEBHOOK_DATA
echo "Signature"
echo $WEBHOOK_SIGNATURE
echo "webhook_guid"
echo $WEBHOOK_GUID


curl -X POST \
    -H "content-type: application/json" \
    -H "User-Agent: User-Agent: GitHub-Hookshot/760256b" \
    -H "x-hub-signature: sha1=$WEBHOOK_SIGNATURE" \
    -H "x-gitHub-delivery: $WEBHOOK_GUID" \
    -H "x-github-event: $GITHUB_EVENT_NAME" \
    --data "{$WEBHOOK_DATA}" $WEBHOOK_ENDPOINT
