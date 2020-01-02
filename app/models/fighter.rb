class Fighter < ActiveRecord::Base
has_many :matches
has_many :betters #HAS MANY THROUGH MATCHES?
end

# increment each second the fighter taking damage in a range of random numbers