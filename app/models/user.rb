# Models an authenticatable and authorizable user.
class User < ActiveRecord::Base
  
  has_and_belongs_to_many :roles, :uniq => true
  
  # Sort users by email by default.
  default_scope :order => 'email ASC'
  
  # Include default devise modules. Others available are:
  # :token_authenticatable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
         :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :confirmed_at, :locked_at
    
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  # Skip confirmation emails when admins create users.
  def save_without_confirmation!
    self.skip_confirmation!
    save()
  end
  
  # Allow admin user management checkbox to set the locked_at time.
  def locked_at=(_locked)
    if _locked.to_i > 0
      self[:locked_at] = Time.now
    else
      self[:locked_at] = nil
    end
  end 
  
  # Make sure all users have at least the :user role.
  def role_ids_with_add_user_role=(_role_ids)
    _role_ids ||= []
    _role_ids << Role.by_name(:user).id
    self[:role_ids] = _role_ids
    self.role_ids_without_add_user_role = _role_ids
  end 
  alias_method_chain :role_ids=, :add_user_role  
   
   # Exclude password info from xml output.
   def to_xml(options={})
     options[:except] ||= [:encrypted_password, :password_salt]
     super(options)
   end
   
   # Exclude password info from json output.
   def to_json(options={})
     options[:except] ||= [:encrypted_password, :password_salt]
     super(options)
   end
  
end
