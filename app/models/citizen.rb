class Citizen  < ActiveRecord::Base

    has_many :positions
    has_many :conversations
    has_many :publications
    has_many :ratings
    
  	before_save :prepare_password
  
	
  	validates_presence_of :email, :message => "Debes ingresar un nombre de usuario"
  	validates_uniqueness_of :email, :message => "ya registrado"
  	validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "El formato del email es invalido"

  	validates_confirmation_of :password
  	validates_length_of :password, :minimum => 4, :allow_blank => true, :message => "Como minimo la password debe tener 4 caracteres"
  
  	# login can be either username or email address
  	def self.authenticate(login, pass)
    	citizen = find_by_email(login)
    	return citizen if citizen && citizen.matching_password?(pass)
  	end
  
  	def matching_password?(pass)
  		puts self.password 
  		puts encrypt_password(pass)
    	self.password == encrypt_password(pass)
  	end
  
  	private
  	def prepare_password
    	unless password.blank?
      		self.password = Digest::SHA1.hexdigest(password)
     	else
     		puts "en blanco"
     	end
    end
  
  	def encrypt_password(pass)
    	Digest::SHA1.hexdigest(pass)
  	end
  	
  	def self.saveImg(upload,c_id)
    	fn =  upload['upload_data'].original_filename
    	directory = "public/images/citizenImg/#{c_id}/"
		FileUtils.mkdir_p directory
    	path = File.join(directory, fn)
    	File.open(path, "wb") { |f| f.write(upload['upload_data'].read) }
		n_path = "#{directory}/#{c_id}.jpg"
    	File.rename(path, n_path)
    	
		return fn
	end
end
