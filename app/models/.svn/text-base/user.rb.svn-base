class User  < ActiveRecord::Base
 	#include MongoMapper::Document
 	#key :username, String
 	#key :email, String
 	#key :password, String
 	#key :password_confirmation, String
    
    many :ubications
  	attr_accessor :password
  	before_save :prepare_password
  
  	validates_presence_of :username, :message => "Debes ingresar un nombre de usuario"
  	validates_uniqueness_of :username, :email, :allow_blank => true, :message => "Ya registrado."
  	validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "El correo electr—nico contiene caracteres no validos"
  	validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "El formato del email es invalido"

  	validates_confirmation_of :password
  	validates_length_of :password, :minimum => 4, :allow_blank => true, :message => "Como m’nimo la password debe tener 4 car‡cteres"
  
  	# login can be either username or email address
  	def self.authenticate(login, pass)
    	user = find_by_username(login) || find_by_email(login)
    	return user if user && user.matching_password?(pass)
  	end
  
  	def matching_password?(pass)
    	self.password == encrypt_password(pass)
  	end
  
  	private
  	def prepare_password
    	unless password.blank?
      		self.password = Digest::SHA1.hexdigest(password)
     	end
    end
  
  	def encrypt_password(pass)
    	Digest::SHA1.hexdigest(pass)
  	end
end
