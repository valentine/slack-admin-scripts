#!/bin/sh

# slinvite lets you invite a user to a Slack channel via the command line

# USAGE
# slinvite.sh username channel-name

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
  echo 1>&2 "Usage: $0 username channel-name"
  exit 3
fi

USER_NAME=$1
CHANNEL_NAME=$2

USER_ID=$(
	curl -s -d "token=$API_TOKEN" https://slack.com/api/users.list | \
	jq ".members[] | select(.name==\"$USER_NAME\") | .id" 2>/dev/null | \
	sed -e 's/^"//' -e 's/"$//'
)

CHANNEL_ID=$(
	curl -s -d "token=$API_TOKEN" https://slack.com/api/channels.list | \
	jq ".channels[] | select(.name==\"$CHANNEL_NAME\") | .id" 2>/dev/null | \
	sed -e 's/^"//' -e 's/"$//'
)

RETURN=$(
	curl -s -d "token=$API_TOKEN&channel=$CHANNEL_ID&user=$USER_ID" \
	https://slack.com/api/channels.invite
)

RETURN_ID=$(
	jq ".channel.members | .[index(\"$USER_ID\")]" <<< $RETURN | \
	sed -e 's/^"//' -e 's/"$//'
)

if [ "$RETURN_ID" = "$USER_ID" ]; then
	echo "DEBUG : Successfully invited \"$USER_NAME\" to #$CHANNEL_NAME."
else
	echo "ERROR : $RETURN"
fi
