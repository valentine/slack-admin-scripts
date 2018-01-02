# (Unofficial) Slack administration scripts

Command line scripts for some common Slack administration tasks.

## Installation

Clone this repository:

    git clone https://github.com/valentine/slack-admin-scripts.git

Make sure that the scripts are executable:

    chmod u+x *.sh

## Usage

Generate an API token for your Slack workspace from [this page](https://api.slack.com/custom-integrations/legacy-tokens).

You may either export it as a **SLACK_TOKEN** environment variable

    export SLACK_TOKEN="xoxp-01234567890-01234567890-012345678901-0a1b2c3d4f5a6b7c8d9e0f1a2b3c4d5e"

or edit the TOKEN variable in the scripts.

### slarchive

**slarchive** lets you archive Slack channels via the command line

    slarchive.sh old-channel

### slcreate

**slcreate** lets you create Slack channels via the command line

    slcreate.sh new-channel

### slinvite

**slinvite** lets you invite a user to a Slack channel via the command line

    slinvite.sh username channel-name

### slrename

**slrename** lets you rename Slack channels via the command line

    slrename.sh old-channel-name new-channel-name

## Licence

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
