# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mongoTest_session',
  :secret      => '1dded8ab28cfbbe04c8b9fe4ccc4b8f837ffc8899ba1c30c74e0b4e40202b6989771b9ea9589c08e16f83fe71613bbb293e0561339bd7388265c7a57671c4e0a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
