# Slacker

https://github.com/neilgupta/slacker/

Simple command line utility for posting messages to Slack.

## Install

    brew install neilgupta/tools/slacker

## Configuration

You should configure a `.slacker` config file in your project's root directory that looks like this:

    webhook="Your Slack Webhook URL"
    username="Your bot's username, defaults to Slacker"
    icon="Your bot's icon, ie :poop:"
    channel="The default channel you want to output to, ie #general"
    text="Some default text to send if you don't specify at run-time"

Slacker will look in the current directory, and then at the top of the git tree for your `.slacker` file.

## Usage

You can also override any of the above options by passing them directly to Slacker at run-time.

    -h "Your bot's webhook URL, like https://hooks.slack.com/services/123...."
    -c "Your bot's channel, like #general"
    -u "Your bot's username, like DeployBot"
    -i "Your bot's icon, like :poop:"
    -t "Text you want to send"

Only the webhook and text parameters are required, and can be defined in your .slacker file or passed as arguments.

    slacker -h WEBHOOK_URL -c SLACK_CHANNEL -u SLACK_USERNAME -i SLACK_EMOJI -t "This is a message from Slacker"

## License

The MIT License (MIT)
Copyright (c) 2016 Neil Gupta

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
