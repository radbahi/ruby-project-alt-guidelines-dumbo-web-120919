class Better < ActiveRecord::Base
has_one :fighter
has_many :matches
end