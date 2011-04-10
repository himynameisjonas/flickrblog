# Load the rails application
require File.expand_path('../application', __FILE__)

require 'yaml'
require 'open-uri'
CONFIG = (YAML.load_file('config/config.yml')[RAILS_ENV] rescue {}).merge(ENV)

# Initialize the rails application
Flickrblog::Application.initialize!
