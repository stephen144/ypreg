source 'https://rubygems.org'
ruby '2.4.1'

gem 'rails', '~> 5.0.0', '>= 5.0.2'

gem 'pg'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'sass-rails', '>= 3.2'
gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.2'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 4.2.1'
gem 'jbuilder'
gem 'activemodel-serializers-xml'
gem 'foreigner'
gem 'immigrant'
gem 'skylight'
gem 'awesome_print'

# Authentication
gem 'devise'

# Authorization
gem 'pundit'

# manage environment variables
gem 'figaro'

# PDF generation
# gem 'prawn'

gem 'simple_form'

# searching
gem 'pg_search'

# Decorator pattern
gem 'draper', '~> 3.0.0.pre1'

# HTML template
gem 'haml-rails'

# Image processing
gem 'mini_magick'

# Avatar uploader
gem 'carrierwave', '~>1.0'

group :production do
  gem 'rails_12factor'
end

group :development do
# Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'better_errors'
  #gem 'quiet_assets'
  gem 'guard-livereload'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'railroady'
  gem 'bullet'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-byebug'
  gem 'binding_of_caller'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'rspec_junit_formatter'
  gem 'factory_girl_rails'
  gem 'faker'
#   gem 'simplecov', require: false
#   gem 'simplecov-csv', require: false
  gem 'coverband'
  gem 'rubocop', '~> 0.45.0', require: false
  gem 'rubocop-rspec', require: false
  gem 'letter_opener', group: :development
end

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  # gem 'poltergeist'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'guard-rspec'
  gem 'timecop'
end

group :doc do
  gem 'sdoc' # require: false
  gem 'yard'
end
