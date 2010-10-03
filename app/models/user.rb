class User < ActiveRecord::Base
  
  has_and_belongs_to_many :roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at
    
  def role?(role)
    return !!Role.by_name(role)
  end
  
  # Make sure all users have at least the :user role.
  def role_ids_with_add_user_role=(_role_ids) 
    user_role = Role.by_name(:user)
    _role_ids << user_role.id
    self[:role_ids] = _role_ids
    self.role_ids_without_add_user_role = _role_ids
   end 
   alias_method_chain :role_ids=, :add_user_role 
  
end
