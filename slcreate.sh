#!/bin/sh

# slcreate lets you create Slack channels via the command line

# USAGE
# slcreate.sh new-channel

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
  echo 1>&2 "Usage: $0 new-channel"
  exit 3
fi

CHANNEL_NAME=$1

RETURN=$(
	curl -s -d "token=$API_TOKEN&name=$CHANNEL_NAME" \
	https://slack.com/api/channels.create | \
	jq '.channel.name' | \
	sed -e 's/^"//' -e 's/"$//'
)

if [ "$RETURN" = "$CHANNEL_NAME" ]; then
	echo "DEBUG : Successfully created channel #$CHANNEL_NAME."
else
	echo "ERROR : $RETURN"
fi
