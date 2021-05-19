# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "active_storage_validations", "0.8.2"
gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap-sass", "3.4.1"
gem "bootstrap-will_paginate", "1.0.0"
gem "cancancan"
gem "config"
gem "devise"
gem "faker", "2.1.2"
gem "figaro"
gem "font-awesome-sass", "~> 5.15.1"
gem "i18n-js"
gem "image_processing", "1.9.3"
gem "jbuilder", "~> 2.7"
gem "jquery-rails", "4.3.1"
gem "mini_magick", "4.9.5"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.3"
gem "rails-i18n"
gem "ransack"
gem "sass-rails", ">= 6"
gem "sidekiq"
gem "toastr-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"
gem "whenever", require: false
gem "will_paginate", "3.1.8"

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 4.0"
  gem "simplecov"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
