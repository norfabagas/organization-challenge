module ThemeHelper

  def btn_general
    current_user.configuration.theme_configuration[:btn_general]
  end

  def btn_form
    current_user.configuration.theme_configuration[:btn_form]
  end

  def bg_color
    user_signed_in? ? current_user.configuration.theme_configuration[:bg_color] : ''
  end

  def btn_danger
    user_signed_in? ? current_user.configuration.theme_configuration[:btn_danger] : 'btn btn-danger'
  end

  def navbar_color
    user_signed_in? ? current_user.configuration.theme_configuration[:navbar_color] : 'navbar-dark bg-info'
  end

  def text_color
    user_signed_in? ? current_user.configuration.theme_configuration[:text_color] : 'text-dark'
  end

  def toggler_color
    current_user.configuration.theme_configuration[:toggler_color]
  end

  def table_class
    "table table-striped table-hover"
  end

  def notice_color
    user_signed_in? ? current_user.configuration.theme_configuration[:notice_color] : 'alert-warning'
  end

  def alert_color
    user_signed_in? ? current_user.configuration.theme_configuration[:alert_color] : 'alert-danger'
  end

end