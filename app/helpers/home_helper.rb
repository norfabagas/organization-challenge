module HomeHelper

  def get_informative_time(datetime)
    if datetime >= Time.current - 30.day
      "#{time_ago_in_words(datetime)} #{I18n.t 'general.ago'}"
    else
      "#{datetime.strftime("%Y/%m/%d")}"
    end
  end

  def card_toggler(target)
    render partial: card_toggler_path, locals: { target: target }
  end

  private

  def card_toggler_path
    "shared/components/card_toggler"
  end
end
