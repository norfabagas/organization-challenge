class ApplicationController < ActionController::Base

  # around_action :switch_locale

  def switch_locale(&action)
    locale = user_signed_in? ? current_user.configuration.locale : 'en'
    I18n.with_locale(locale, &action)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = 'You are unauthorized to access to specific page'
    redirect_to root_path
  end

end