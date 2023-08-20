# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "bootsnap", require: false
gem "cpf_cnpj", "~> 0.5.0"
gem "importmap-rails"
gem "isbn", "~> 2.0", ">= 2.0.11"
gem "jbuilder"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0", ">= 7.0.7"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "factory_bot_rails", "~> 6.2"
  gem "ffaker", "~> 2.21"
  gem "rspec-rails", "~> 6.0", ">= 6.0.2"
  gem "rubocop-rails", "~> 2.19", ">= 2.19.1", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "webdrivers"
end
