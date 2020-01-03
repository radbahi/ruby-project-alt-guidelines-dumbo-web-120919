class Better < ActiveRecord::Base
belongs_to :fighter
has_many :matches
end