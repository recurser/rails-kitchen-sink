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
  
  # Make sure everyone always has at least the :user role.
  def role_ids=(val)
    logger.debug '================================'
    logger.debug val
    user_role = Role.by_name(:user)
    val << user_role.id unless val.include? user_role.id
    @role_ids = val
    logger.debug val
    logger.debug '================================'
    self.save
  end
  
end
