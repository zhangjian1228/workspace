class TwitterService
	def initialize(account) 	
		@account = account 	
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = "Jc83WnD1zuET0bUEDYS9viItO"
			config.consumer_secret     = "17ScKQD0WP4kb8beGeBipirYpfF3mzi6Vpgyat8j0TlbnCil93"
		end
	end

	def get_tweets_with_options(max_id = nil)  # define method
		options = {
			count: 200
		}
		# -1 for getting unique tweets
		options[:max_id] = max_id - 1 if max_id 

		puts "Getting tweets with max id #{max_id}"

		begin
			# // prevetn overloading of the twitter api
			sleep 1
			return @client.user_timeline(@account, options) 
															
		rescue
			puts "There was an error obtaining tweets from twitter"
			return []
		end
	end

	def get_tweets
		date_until = Date.new(2016,1,1)
		# date_until = Date.new(2016,5,30)

		tweets = get_tweets_with_options
		result = tweets

		while (tweets.last.created_at.to_date > date_until)
			unless tweets.empty?
				puts "Last tweet was on #{tweets.last.created_at.to_date}"
			end
			puts "We need more tweets... Getting tweets with max_id #{tweets.last.id}"
			tweets = get_tweets_with_options(tweets.last.id)
			result += tweets
			break if tweets.empty?
		end 
		
		return result
	end
end

def lengthen(url)
  uri = URI(url)
  Net::HTTP.new(uri.host, uri.port).get(uri.path).header['location']
end

class DashboardController < ApplicationController
	def index
		@tweets = Tweet.all
	end
	
  def load
    require 'twitter'
    #require 'date'				#reuire means import library
    require "awesome_print"
    #require 'uri'
    #require 'net/http'
    
    
    service = TwitterService.new("cnn")
    tweets = service.get_tweets
    File.open("result.csv", "w+") do |file|
    	file.puts "ID, Text, Created_at, Link"
    	tweets.each do |tweet|
    		t = Tweet.create(t_id: tweet.id, body: tweet.text, t_created_at: tweet.created_at)
    		# ap tweet
    		file.puts "#{tweet.id},#{tweet.text},#{tweet.created_at}, #{tweet.uris.collect{|url| lengthen(url.expanded_url)}.join('')}"
    		puts tweet.id
    		puts tweet.text
    		puts tweet.created_at
    		puts tweet.uris.collect{|url| lengthen(url.expanded_url)}.join(" ")
    		tweet.uris.each do |url|
    			t.mappings << Mapping.create(url: lengthen(url.expanded_url))
    		end
    		puts "-------"
    	end
    end
    # http://www.rubydoc.info/gems/twitter/Twitter/REST/Timelines#user_timeline-instance_method
    puts "Total tweets: #{tweets.count} // user_timeline method limits the reutrn to 32000 tweets"
    
    redirect_to tweets_path
  end
end
