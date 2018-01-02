#!/bin/sh

# slrename lets you rename Slack channels via the command line

# USAGE
# slrename.sh old-channel-name new-channel-name

# You will need admin privileges in your Slack workspace
# to rename channels you did not create.

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

if [ $# -ne 2 ]; then
  echo 1>&2 "Usage: $0 old-channel-name new-channel-name"
  exit 3
fi

OLD_NAME=$1
NEW_NAME=$2

CHANNEL_ID=$(
	curl -s -d "token=$API_TOKEN" https://slack.com/api/channels.list | \
	jq ".channels[] | select(.name==\"$OLD_NAME\") | .id" 2>/dev/null | \
	sed -e 's/^"//' -e 's/"$//'
)

RETURN=$(
	curl -s -d "token=$API_TOKEN&channel=$CHANNEL_ID&name=$NEW_NAME" \
	https://slack.com/api/channels.rename
)

RETURN_NAME=$(
	jq '.channel.name' <<< $RETURN | \
	sed -e 's/^"//' -e 's/"$//'
)

if [ "$RETURN_NAME" = "$NEW_NAME" ]; then
	echo "DEBUG : Successfully renamed \"#$OLD_NAME\" to \"#$NEW_NAME\"."
else
	echo "ERROR : $RETURN"
fi
