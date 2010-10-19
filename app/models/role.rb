# Models roles used for authorizing users and limiting access to
# certain parts of the application.
class Role < ActiveRecord::Base
  
  has_and_belongs_to_many :users, :uniq => true
  
  # Sort roles by name by default.
  scope :roles_sorted, :order => 'name ASC'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Allows us to look up roles by passing a symbol, eg. Role.by_name(:admin)
  def self.by_name(name)
    self.find_by_name(name.to_s.camelize)
  end
  
end
