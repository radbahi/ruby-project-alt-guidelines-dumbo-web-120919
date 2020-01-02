class Match < ActiveRecord::Base
has_many :betters, through: :fighters
has_many :fighters
end

# create a bet pool of money and distribute evenly amongst those who won