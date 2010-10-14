require 'spec_helper'

describe Notifier do
  
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    
    describe 'with valid configuration' do

      before(:all) do
        @attr = {
          :email   => 'mail@recursive-design.com',
          :subject => 'Urgent Problem',
          :body    => 'Please reply ASAP!'
        }
        contact = Contact.new(@attr)
        @email = Notifier.contact_notification(contact)
      end

      it 'should deliver to the correct email' do
        @email.should deliver_to(@attr[:email])
      end

      it 'should have the correct subject' do
        @email.should have_subject(@attr[:subject])
      end

      it 'should have the correct body' do
        @email.should have_body_text(@attr[:body])
      end
      
    end
    
    describe 'with invalid configuration' do

      before(:all) do
        APP_CONFIG['contact_to_address'] = false
      end

      after(:all) do
        APP_CONFIG['contact_to_address'] = 'mail@recursive-design.com'
      end
    
      it 'should raise an exception' do
        APP_CONFIG['contact_to_address'] = false
        contact = Contact.new()
        lambda {Notifier.contact_notification(contact)}.should raise_error(ArgumentError)
      end
    
    end
  
end
