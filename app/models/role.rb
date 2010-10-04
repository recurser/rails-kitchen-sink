class Role < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  
  # Sort roles by name by default.
  scope :roles_sorted, :order => 'name ASC'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.by_name(name)
    self.find_by_name(name.to_s.camelize)
  end
  
end
