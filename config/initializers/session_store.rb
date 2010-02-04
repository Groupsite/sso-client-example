# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bioworks_session',
  :secret      => '130797c67ca42fedabd489d91d36f7fda29a76380edc53bda948eb959df59f8ec3a4aaa053bf15c952a7f6376c5334dff45066c31e2e4fbfbc68d85db7979fbe'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
