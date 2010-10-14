require 'spec_helper'

describe Role do
  
    it 'should require a name' do
      no_name_role = Role.new({:name => ''})
      no_name_role.should_not be_valid
    end
  
    it 'should have a unique name' do
      role_1 = Role.new({:name => 'role_1'})
      role_1.save
      role_2 = Role.new({:name => 'role_1'})
      role_2.should_not be_valid
    end
  
    it 'should return the correct role when *by_name* is called' do
      user_role = Role.new({:name => 'User'})
      user_role.save
      Role.by_name(:user).id.should == user_role.id
    end
    
end
