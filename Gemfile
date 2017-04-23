# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'

gem 'active_model_serializers', '~> 0.10.0'

# gem 'nokogiri', '~> 1.6', '>= 1.6.8'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# gem 'redis-namespace'
# gem 'redis-rails'
# gem 'redis-rack-cache'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS)
gem 'rack-cors'

# Rack::Attack is a rack middleware to protect your web app from bad clients.
# It allows safelisting, blocklisting, throttling,
# and tracking based on arbitrary properties of the request.
gem 'rack-attack'

gem 'rubocop', '~> 0.46.0', require: false

gem 'rspotify', '>= 1.19.0'

group :development, :test do
  gem 'pry'
  gem 'sqlite3'
  # Use RSpec for specs
  gem 'rspec-rails', '>= 3.5.0'

  # Use Factory Girl for generating random test data
  gem 'factory_girl_rails'

  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running
  # in the background. # Read more: https://github.com/rails/spring
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano3-puma',   require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '~> 0.19.0.pre20160409114042'
  gem 'rails_12factor'
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
