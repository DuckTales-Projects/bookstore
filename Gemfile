# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bootsnap', require: false

gem 'pg'

gem 'puma'

gem 'rails', github: 'rails/rails', branch: 'main'

gem 'rubocop', require: false

gem 'rubocop-performance'

gem 'rubocop-rails'

gem 'rubocop-rspec', require: false

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'codecov', require: false
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'shoulda-matchers'
  gem 'simplecov'
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  end
end
