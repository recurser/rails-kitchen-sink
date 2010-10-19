# Represents a message sent to the site admins via the contact form.
class Contact
  
  include ActiveModel::Validations
  
  validates_presence_of :email, :subject, :body 
  validates_format_of   :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  
  # To deal with the form, you must have an id attribute.
  attr_accessor :id, :email, :subject, :body
  
  # Initialise the various attributes - needed because we don't inherit from ActiveRecord::Base.
  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes = attributes
  end
  
  # Needed because we don't inherit from ActiveRecord::Base.
  def to_key
    ['new']
  end
  
  # Needed because we don't inherit from ActiveRecord::Base.
  def read_attribute_for_validation(key)
    @attributes[key]
  end
  
  # If the model validates, send the message.
  def save
    if self.valid?
      Notifier.contact_notification(self).deliver
      return true
    end
    
    return false
  end
  
end
