source :rubygems

gem "sinatra"
gem "thin"
gem "couchdb-ruby"
gem "twilio-ruby"
gem "shotgun"
gem "koala"
gem "oauth2"
gem "datamapper", "1.2.0"
gem "mysql"

group :production do
	gem 'dm-postgres-adapter'
end

group :test, :development do
	gem 'dm-sqlite-adapter'
	gem 'do_sqlite3'
end
