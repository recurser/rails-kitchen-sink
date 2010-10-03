class Role < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  
  # Sort roles by name by default.
  named_scope :roles_sorted, :order => 'name ASC'
  
  def self.by_name(name)
    self.find_by_name(name.to_s.camelize)
  end
  
end
