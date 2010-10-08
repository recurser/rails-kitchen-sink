require 'spec_helper'

describe Role do

  describe "validations" do
  
    it "should require a name" do
      no_name_role = Role.new({:name => ''})
      no_name_role.should_not be_valid
    end
  
    it "name should be unique" do
      role_1 = Role.new({:name => 'role_1'})
      role_1.save
      role_2 = Role.new({:name => 'role_1'})
      role_2.should_not be_valid
    end
    
  end

  describe "convenience methods" do
  
    it "by_name should return the correct role" do
      user_role = Role.new({:name => 'User'})
      user_role.save
      Role.by_name(:user).id.should == user_role.id
    end
    
  end
    
end
