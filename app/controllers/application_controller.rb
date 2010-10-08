class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  # Get roles accessible by the current user
  def accessible_roles
    # Don't display user role - it gets added automatically and should be transparent to the system.
    @accessible_roles = Role.accessible_by(current_ability, :read) - [Role.by_name(:user)]
  end
 
  # Make the current user object available to views
  def get_user
    @current_user = current_user
  end
  
end
