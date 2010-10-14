class Notifier < ActionMailer::Base
  
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
