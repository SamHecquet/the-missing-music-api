source 'https://rubygems.org'


ruby '2.3.0'
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

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Rack::Attack is a rack middleware to protect your web app from bad clients. It allows safelisting, blocklisting, throttling, and tracking based on arbitrary properties of the request.
gem 'rack-attack'

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  # Use RSpec for specs
  gem 'rspec-rails', '>= 3.5.0'

  # Use Factory Girl for generating random test data
  gem 'factory_girl_rails'
end


group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg' 
  gem 'rails_12factor'
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]