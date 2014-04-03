class Conversation < ActiveRecord::Base
	has_many :publications
    belongs_to :citizen
end
