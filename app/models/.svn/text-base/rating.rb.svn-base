class Rating < ActiveRecord::Base
 	#include MongoMapper::Document
 	#key :citizen_id, ObjectId
 	#key :publication_id, ObjectId
 	#key :tipo, String	#positivo, negativo
 	    
	has_one :citizen
	has_one :conversation
end
