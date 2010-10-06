RecursiveRailsStarter::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  ActionMailer::Base.delivery_method = :sendmail
  
  # Bullet configuration.
  # http://github.com/flyerhzm/bullet#readme
  config.after_initialize do
    Bullet.enable                 = true 
    Bullet.alert                  = true
    Bullet.bullet_logger          = true  
    Bullet.console                = true
    begin
      require 'ruby-growl'
      Bullet.growl                = true
    rescue MissingSourceFile
    end    
    Bullet.rails_logger           = true
    Bullet.disable_browser_cache  = true
  end
  
end

