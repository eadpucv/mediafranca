class Senator < ActiveRecord::Base
 	#include MongoMapper::Document
 	#key :citizen_id, ObjectId
 	#key :circumscription_id, ObjectId
 	    
	belongs_to :circumscription
	has_one :citizen

end
