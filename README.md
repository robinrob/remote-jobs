# RSS Opener

Short Ruby script that presents a pretty terminal interface for quickly opening articles from RSS feeds in a web browser.

The environment variable BROWSER is used to open the web browser and should be set to the OS X application name of the
browser, e.g.: `Safari`, `Google\ Chrome`, `Firefox`. The name is not case-sensitive.

## Installation

-- `bundle install` to install required Ruby Gems.

## Usage

`./rss-opener.rb <rss url> <article limit>`

Articles are limited to top 10 by default.

### Examples

Display top 10 news items from Hacker News RSS feed:
`./rss-opener.rb https://news.ycombinator.com/rss`

Display top 20 news items from Hacker News RSS feed:
`./rss-opener.rb https://news.ycombinator.com/rss 20`