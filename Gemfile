source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

ruby '3.0.0'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-reloader', require: false
gem 'activerecord', '5.2.8.1', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'sqlite3', '~> 1.3', '< 1.5'
gem 'pg'
gem 'rake'
gem 'shotgun'
gem 'pry'
gem 'thin'
gem 'tux'
gem 'require_all'
gem 'bcrypt'
gem 'rack-flash3'

group :development do
  gem “sqlite3”
  gem “pry”
  gem “tux”
  gem “faker”
end

group :production do
  gem “pg”
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
