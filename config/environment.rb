# Load the rails application
require File.expand_path('../application', __FILE__)

Sass::Plugin.options[:template_location] = { 'app/stylesheets' => 'public/stylesheets' }

# Initialize the rails application
RecursiveRailsStarter::Application.initialize!
