class User < ActiveRecord::Base
  
  has_and_belongs_to_many :roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at
    
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
end
