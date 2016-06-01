class Mapping < ActiveRecord::Base
    belongs_to :tweet
end

# m = Mapping.first
# m.tweet.body
