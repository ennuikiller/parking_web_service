# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_parking_session',
  :secret      => '9d15db1278da236dd8b2a7da9136e16a80553e6d65ba0cbd5f2dd04e0bdd7145de9675c3272e62b69bf8b59fa07cec4c448a6c53392f8efb950789ffb55d5799'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
