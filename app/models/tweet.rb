class Tweet < ActiveRecord::Base
    has_many :mappings
end


# t = Tweet.first
# t.mappings -> []
# t.mappings[0].url