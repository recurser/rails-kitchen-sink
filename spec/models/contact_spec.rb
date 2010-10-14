require 'spec_helper'

describe Contact do

  before(:each) do
    @attr = {
      :email   => 'mail@recursive-design.com',
      :subject => 'Urgent Problem',
      :body    => 'Please reply ASAP!'
    }
  end

  it 'should create a new instance given valid attributes' do
    valid_contact = Contact.new(@attr)
    valid_contact.should be_valid
  end

  it 'should save successfully given valid attributes' do
    valid_contact = Contact.new(@attr)
    valid_contact.save.should == true
  end

  it 'should fail to save given valid attributes' do
    valid_contact = Contact.new(@attr.merge(:email => ''))
    valid_contact.save.should == false
  end

  describe 'email validations' do
  
    it 'should require an email address' do
      no_email_contact = Contact.new(@attr.merge(:email => ''))
      no_email_contact.should_not be_valid
    end

    it 'should accept valid email addresses' do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_contact = Contact.new(@attr.merge(:email => address))
        valid_email_contact.should be_valid
      end
    end

    it 'should reject invalid email addresses' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_contact = Contact.new(@attr.merge(:email => address))
        invalid_email_contact.should_not be_valid
      end
    end
  end

  it 'should require a subject' do
    no_subject_contact = Contact.new(@attr.merge(:subject => ''))
    no_subject_contact.should_not be_valid
  end

  it 'should require a body' do
    no_body_contact = Contact.new(@attr.merge(:body => ''))
    no_body_contact.should_not be_valid
  end
  
end
