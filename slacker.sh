#!/bin/bash

set -e

VERSION="1.0"

help="
    Slacker, version ${VERSION}
    Copyright (C) 2016 Neil Gupta

    Simple command line utility for posting messages to Slack.

    You should configure a .slacker config file in your project's root directory that looks like this:

    webhook=\"Your Slack Webhook URL\"
    username=\"Your bot's username, defaults to Slacker\"
    icon=\"Your bot's icon, ie :poop:\"
    channel=\"The default channel you want to output to, ie #general\"
    text=\"Some default text to send if you don't specify at run-time\"

    Slacker will look in the current directory, and then at the top of the git tree for your .slacker file.

    You can also override any of the above options by passing them directly to Slacker at run-time.

      -h \"Your bot's webhook URL, like https://hooks.slack.com/services/123....\"
      -c \"Your bot's channel, like #general\"
      -u \"Your bot's username, like DeployBot\"
      -i \"Your bot's icon, like :poop:\"
      -t \"Text you want to send\"

    Only the webhook and text parameters are required, and can be defined in your .slacker file or passed as arguments.

    USAGE: slacker [-h WEBHOOK_URL] [-c SLACK_CHANNEL] [-u SLACK_USERNAME] [-i SLACK_EMOJI] [-t \"This is a message from Slacker\"]
"

# Check environment args

text=$1

if [ "${text}" == "--help" ]; then
  echo "${help}"
  exit
fi

if [ "${text}" == "--version" ]; then
  echo "${VERSION}"
  exit
fi

# Try to load .slacker config file from current directory
ROOT=`pwd`
if [ -f "$ROOT/.slacker" ]; then
  source "$ROOT/.slacker"
else
  # That didn't work, let's try top-level of git repo
  if [ $(git rev-parse --show-toplevel 2> /dev/null) ]; then
    ROOT=`git rev-parse --show-toplevel`
    source "$ROOT/.slacker"
  fi
fi

# load command line options
while getopts h:u:i:c:t: option
do
  case "${option}" in
    h) webhook=${OPTARG};;
    u) username=${OPTARG};;
    i) icon=${OPTARG};;
    c) channel=${OPTARG};;
    t) text=${OPTARG};;
  esac
done

if [ -z "${text}" ]; then
  echo "${help}"
  exit 1
fi

# make sure after all of the above attempts, we have a webhook url
if [ -z "${webhook}" ]; then
  echo "You must provide a slack webhook url to post messages to Slack. A webhook url looks like https://hooks.slack.com/services/123...."
  exit 1
fi

# Check optional parameters
if [ -z "${channel}" ]; then
  slacker_channel=""
else
  slacker_channel=", \"channel\": \"${channel}\""
fi

if [ -z "${icon}" ]; then
  icon_emoji=""
else
  icon_emoji=", \"icon_emoji\": \"${icon}\""
fi

if [ -z "${username}" ]; then
  slacker_username=", \"username\": \"Slacker\""
else
  slacker_username=", \"username\": \"${username}\""
fi

# Construct payload of text and optional parameters
payload="payload={\"text\": \"${text}\"${slacker_channel}${slacker_username}${icon_emoji}}"

# Send it!
curl -X POST --data-urlencode "${payload}" $webhook
