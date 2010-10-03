class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    # Don't display user role - it gets added automatically and should be transparent to the system.
    @accessible_roles = Role.accessible_by(current_ability, :read) - [Role.by_name(:user)]
  end
 
  # Make the current user object available to views
  #----------------------------------------------------
  def get_user
    @current_user = current_user
  end

  #----------------------------------------------------
  def respond_to_not_found(*types)
    asset = self.controller_name.singularize
    flick = case self.action_name
      when "destroy" then "delete"
      when "promote" then "convert"
      else self.action_name
    end
    if self.action_name == "show"
      flash[:warning] = t(:msg_asset_not_available, asset)
    else
      flash[:warning] = t(:msg_cant_do, :action => flick, :asset => asset)
    end
    respond_to do |format|
      format.html { redirect_to(:action => :index) }                         if types.include?(:html)
      format.js   { render(:update) { |page| page.reload } }                 if types.include?(:js)
      format.xml  { render :text => flash[:warning], :status => :not_found } if types.include?(:xml)
    end
  end
  
end
