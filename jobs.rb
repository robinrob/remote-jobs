#!/usr/bin/env ruby

require 'simple-rss'
require 'open-uri'
require 'colorize'

Urls = [
  "https://nodesk.co/index.xml",
  # "https://angel.co/index.xml"
]

class NoDeskJobsFilter
  def apply(item)
    item.link.start_with? 'https://nodesk.co/remote-jobs/engineering' and item.title.downcase.include? 'full stack'
  end
end

UrlFilters = [
  NoDeskJobsFilter.new  
]

def item_allowed(item, filters)
  filters.all? {|filter| filter.apply(item)}
end

FeedLimit = ARGV[1].nil? ? 10000 : ARGV[1]

# Urls.each do |url|
  url = Urls[0]
  open(url) do |rss|
    feed = SimpleRSS.parse open(url)
    feed.channel.title.length.times { printf '-'.white }; puts
    printf "#{feed.channel.title}\n".cyan
    feed.channel.title.length.times { printf '-'.white }; puts; puts
    
    (feed.items.select {|item| item_allowed(item, UrlFilters)}).sort_by(&:pubDate)[0...FeedLimit].each_with_index do |item, index|
      printf '['.cyan << "#{index}".white << '] '.cyan
      puts "#{item.title} - #{item.pubDate}".white
      puts "#{item.link}".yellow
      puts
    end
    
    printf "Choose article: ".cyan
    while (choice = $stdin.gets.chomp) do
      if (choice.numeric?)
        `open -a #{ENV['BROWSER_APP']} #{feed.items[choice.to_i].link}`
      elsif (choice.empty?)
        break;
      else
        puts "Must choose a number within range of options.".red
      end
      printf "Choose article: ".cyan
    end
  end
# end
