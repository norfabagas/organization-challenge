class RegistrationsController < Devise::RegistrationsController

  def change_password
    @user = current_user
    if @user
      render :change_password
    else
      render file: 'public/404', status: 404
    end
  end

  def cancel_account
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      unless request.referer.include? user_change_password_path 
        respond_with resource
      else
        flash[:errors] = resource.errors
        redirect_to user_change_password_path
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit( :name,
                                  :phone,
                                  :email,
                                  :password,
                                  :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit( :name,
                                  :phone,
                                  :avatar,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :current_password)
  end
end