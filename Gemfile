source 'https://rubygems.org'


gem 'rails', '4.2.1'
gem 'rails-api', '~> 0.4.0'
gem 'pg', '~> 0.18.1'
gem 'puma', '~> 2.11.1'
gem 'bcrypt', '~> 3.1.7'
gem 'active_model_serializers', '0.10.0.rc3'
gem 'pundit', '~> 0.3.0'
gem 'rack-cors', require: 'rack/cors'
gem 'activerecord-import', '>= 0.2.0'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'guard-rspec', '~> 4.2'
  gem 'rb-fsevent', '~> 0.9'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.2.1'
  gem 'pry-rails', '~> 0.3.4'
end

group :test do
  gem 'database_cleaner', '~> 1.1.1'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'shoulda-matchers', require: false
  gem 'timecop', '~> 0.6.3'
end

group :production do
  gem 'rails_12factor'
end
