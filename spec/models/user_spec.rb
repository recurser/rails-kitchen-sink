require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :email => 'railskitchensink@recursive-design.com',
      :password => '123456',
      :password_confirmation => '123456'
    }
  end

  it 'should create a new instance given valid attributes' do
    User.create!(@attr)
  end

  describe 'email validations' do
  
    it 'should require an email address' do
      no_email_user = User.new(@attr.merge(:email => ''))
      no_email_user.should_not be_valid
    end

    it 'should accept valid email addresses' do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end

    it 'should reject invalid email addresses' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end

    it 'should reject duplicate email addresses' do
      # Put a user with given email address into the database.
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end

    it 'should reject email addresses identical up to case' do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end

  describe 'password validations' do

    it 'should require a password' do
      User.new(@attr.merge(:password => '', :password_confirmation => '')).
        should_not be_valid
    end

    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => 'invalid')).
        should_not be_valid
    end

    it 'should reject short passwords' do
      short = 'a' * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it 'should reject long passwords' do
      long = 'a' * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe 'password encryption' do

    before(:each) do
      @user = User.create!(@attr)
    end

    it 'should have an encrypted password attribute' do
      @user.should respond_to(:encrypted_password)
    end
    
    it 'should set the encrypted password' do
      @user.encrypted_password.should_not be_blank
    end
        
  end
  
  describe 'automatic user role' do

    before(:each) do
      Factory(:role, :name => 'User')
      @user = User.create!(@attr)
    end

    it 'should automatically get the user role when setting role_ids=' do
      admin_role = Factory(:role, :name => 'Admin')
      @user.role_ids = [admin_role.id]
      @user.should have(2).roles
    end
        
  end

  describe 'xml & json rendering' do

    before(:each) do
      @user = User.create!(@attr)
    end
    
    it 'should not contain the encrypted password in xml' do
      @user.to_xml.should_not =~ /encrypted_password/i
    end
    
    it 'should not contain the password salt in xml' do
      @user.to_xml.should_not =~ /password_salt/i
    end
    
    it 'should not contain the encrypted password in json' do
      @user.to_json.should_not =~ /encrypted_password/i
    end
    
    it 'should not contain the password salt in json' do
      @user.to_json.should_not =~ /password_salt/i
    end
    
  end
  
end