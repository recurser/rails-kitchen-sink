require 'spec_helper'

describe Contact do

  describe "validations" do
  
    it "should require an email" do
      no_email_contact = Contact.new({:email => ''})
      no_email_contact.should_not be_valid
    end
  
    it "should require a valid email" do
      invalid_email_contact = Contact.new({:email => 'test@test'})
      invalid_email_contact.should_not be_valid
    end
  
    it "should require a subject" do
      no_subject_contact = Contact.new({:subject => ''})
      no_subject_contact.should_not be_valid
    end
  
    it "should require a body" do
      no_body_contact = Contact.new({:body => ''})
      no_body_contact.should_not be_valid
    end
    
  end
  
end
