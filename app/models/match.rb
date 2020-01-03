class Match < ActiveRecord::Base
    has_many :fighters
    has_many :betters
end

# create a bet pool of money and distribute evenly amongst those who won