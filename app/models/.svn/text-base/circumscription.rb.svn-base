class Circumscription < ActiveRecord::Base
 	#include MongoMapper::Document
 	#key :name, String
 	#key :region_id, ObjectId
    
    belongs_to :region
    many :districts
    many :senators

end
