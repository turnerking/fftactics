# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fftactics_session',
  :secret      => '326288780a316fce4da31b8b80733e02935d60de940afff3a3a00c528110d52aa4f2b9184df8c4f437377ea0a28cb7b0565667f45445bc40c92a5c689e1e0b7c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
