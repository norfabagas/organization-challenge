class HomeController < ApplicationController

  require 'home_helper'

  include HomeHelper
  
  before_action :authenticate_user!

  def index
  end

  def profile
  end

  def configure
    if request.post?
      @configuration = current_user.configuration
      if @configuration.update(configuration_params)
        return redirect_to profile_path,
        notice: 'Configuration updated'
      else
        render :configure
      end
    else
      @configuration = current_user.configuration
    end
  end

  private

  def configuration_params
    params.require(:configuration).permit(  :theme,
                                            :locale)
  end
end
