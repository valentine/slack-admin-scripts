#!/bin/sh

# slarchive lets you archive Slack channels via the command line

# USAGE
# slarchive.sh old-channel

# Generate a token for your Slack workspace from
# https://api.slack.com/custom-integrations/legacy-tokens

# You may export it as a $SLACK_TOKEN environment variable
# instead of editing the line below.

TOKEN="xoxp-01234567890-01234567890-012345678901-0a1b2c3d4f5a6b7c8d9e0f1a2b3c4d5e"

if [ -z "$SLACK_TOKEN" ]; then
	API_TOKEN=$TOKEN
else
	API_TOKEN=$SLACK_TOKEN
fi

if [ $# -ne 1 ]; then
  echo 1>&2 "Usage: $0 old-channel"
  exit 3
fi

CHANNEL_NAME=$1

CHANNEL_ID=$(
	curl -s -d "token=$API_TOKEN" https://slack.com/api/channels.list | \
	jq ".channels[] | select(.name==\"$CHANNEL_NAME\") | .id" 2>/dev/null | \
	sed -e 's/^"//' -e 's/"$//'
)

RETURN=$(
	curl -s -d "token=$API_TOKEN&channel=$CHANNEL_ID" \
	https://slack.com/api/channels.archive | \
	jq '.ok'
)

if [ "$RETURN" = true ]; then
	echo "DEBUG : Successfully archived channel #$CHANNEL_NAME."
else
	echo "ERROR : $RETURN"
fi
