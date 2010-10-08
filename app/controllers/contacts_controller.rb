class ContactsController < ApplicationController
  
  def new
    @title = 'contacts.title_new'
    # id is used to deal with form
    @contact = Contact.new(:id => 1)
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      redirect_to(root_path, :notice => t('contacts.flash.message_sent'))
    else
      flash[:alert] = t 'contacts.flash.invalid_form_warning'
      render 'new'
    end
  end
  
end
