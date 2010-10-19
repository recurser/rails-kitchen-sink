class Ability
  include CanCan::Ability
 
  def initialize(user)
    # Handle guest users.
    user ||= User.new 
    
    if user.role? :admin
      can :create, :all
      can :update, :all
      can :read, :all 
      # Users can't delete themselves.
      can :destroy, User do |other_user|
        other_user.try(:id) != user.id
      end
  
    elsif user.role? :user
      
    end
  end
  
end