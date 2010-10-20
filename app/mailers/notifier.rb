# Used to send contact emails to the site admin.
class Notifier < ActionMailer::Base
  
  # Sends the contact email using the parameters from the given Contact instance.
  def contact_notification(contact)
    @contact = contact
    
    unless APP_CONFIG['contact_to_address']
      raise ArgumentError, "Please set a contact_to_address in your application's config."
    end
    
    mail(:to      => APP_CONFIG['contact_to_address'],
         :from    => contact.email,
         :subject => contact.subject)
 end

end
