# Base class for handling authorization with CanCan.
class Ability
  
  include CanCan::Ability
 
  # Defines permissions for various classes of users.
  def initialize(user)
    # Handle guest users.
    user ||= User.new 
    
    if user.role? :admin
      can :create, :all
      can :update, :all
      can :read, :all 
      # Admin users can't delete themselves.
      can :destroy, User do |other_user|
        other_user.try(:id) != user.id
      end
  
    elsif user.role? :user
      # Regular users can only manage themselves.
      can :manage, User do |action, other_user|
        other_user.try(:id) == user.id
      end
    end
  end
  
end