# Displays a basic contact form, and handles form submissions.
class ContactsController < ApplicationController
  
  # Displays a blank contact form.
  def new
    # id is used to deal with form
    @contact = Contact.new(:id => 1)
  end
  
  # Handles posting of the form, and mails a message to the site owner.
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
