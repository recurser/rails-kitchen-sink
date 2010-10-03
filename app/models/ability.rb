class Ability
  include CanCan::Ability
 
  def initialize(user)
    # Handle guest users.
    user ||= User.new 
 
    if user.role? :admin
      can :manage, :all
    elsif user.role? :user
      can :manage, User do |user|
        product.try(:id) == user.id
      end
    end
  end
  
end