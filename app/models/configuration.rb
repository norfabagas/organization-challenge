class Configuration < ApplicationRecord
  AVAILABLE_THEMES = [
    'default', 
    'dark',
    'green',
    'yellow',
    'red'
  ]

  AVAILABLE_LOCALE = [
    'en',
    'id'
  ]

  DEFAULT_THEME = {
    btn_general: 'btn btn-secondary',
    btn_form: 'btn btn-info',
    btn_danger: 'btn btn-danger',
    bg_color: 'bg-light',
    navbar_color: 'navbar-dark bg-info',
    text_color: 'text-dark',
    toggler_color: 'btn btn-dark',
    notice_color: 'alert-warning',
    alert_color: 'alert-danger'
  }
  
  DARK_THEME = {
    btn_general: 'btn btn-light',
    btn_form: 'btn btn-light',
    btn_danger: 'btn btn-warning',
    bg_color: 'bg-secondary',
    navbar_color: 'navbar-dark bg-dark',
    text_color: 'text-light',
    toggler_color: 'btn btn-light',
    notice_color: 'alert-dark',
    alert_color: 'alert-warning'
  }

  GREEN_THEME = {
    btn_general: 'btn btn-success',
    btn_form: 'btn btn-success',
    btn_danger: 'btn btn-danger',
    bg_color: 'bg-light',
    navbar_color: 'navbar-dark bg-success',
    text_color: 'text-dark',
    toggler_color: 'btn btn-success',
    notice_color: 'alert-warning',
    alert_color: 'alert-danger'
  }
  
  YELLOW_THEME = {
    btn_general: 'btn btn-warning',
    btn_form: 'btn btn-warning',
    btn_danger: 'btn btn-danger',
    bg_color: 'bg-light',
    navbar_color: 'navbar-light bg-warning',
    text_color: 'text-dark',
    toggler_color: 'btn btn-dark',
    notice_color: 'alert-warning',
    alert_color: 'alert-danger'
  }
  RED_THEME = {
    btn_general: 'btn btn-dark',
    btn_form: 'btn btn-dark',
    btn_danger: 'btn btn-danger',
    bg_color: 'bg-light',
    navbar_color: 'navbar-dark bg-danger',
    text_color: 'text-dark',
    toggler_color: 'btn btn-secondary',
    notice_color: 'alert-warning',
    alert_color: 'alert-danger'
  }

  belongs_to :user

  validates :theme, presence: true, length: {maximum: 255}, inclusion: { in: AVAILABLE_THEMES }
  validates :locale, presence: true, length: {maximum: 255}, inclusion: { in: AVAILABLE_LOCALE }

  def theme_configuration
    case self.theme
    when 'dark'
      DARK_THEME
    when 'green'
      GREEN_THEME
    when 'yellow'
      YELLOW_THEME
    when 'red'
      RED_THEME
    else
      DEFAULT_THEME
    end
  end
end
