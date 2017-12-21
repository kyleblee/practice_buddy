module LicksHelper

  def render_sorted_view(user, licks, params)
    if params[:sort] == "Tonality" || params[:sort] == "Artist"
      render partial: "sort_with_headers", locals: {user: user, licks: licks}
    elsif params[:sort] == "Date Last Practiced"
      render partial: "sort_without_headers", locals: {user: user, licks: licks, extra_info_method: :date_last_practiced}
    elsif params[:sort] == "Scheduled Practice Date"
      render partial: "sort_without_headers", locals: {user: user, licks: licks, extra_info_method: :scheduled_practice_date}
    else
      render partial: "sort_without_headers", locals: {user: user, licks: licks, extra_info_method: :tonality_list}
    end
  end

  def tonality_list(lick)
    unless lick.tonalities.empty?
      return_list = "("

      list = lick.tonalities.enum_for(:each_with_index).collect do |t, i|
        i == 0 ? t.name : ", #{t.name}"
      end

      return_list << list.join + ")"
    end
    return_list
  end

  def date_last_practiced(lick)
    # Less than DRY to avoid conditionals having to be called for every list item. This way,
    # the conditionals are only run once (before the list is rendered) so that the method call
    # for each item can be a little quicker.
    if lick.last_practiced
      lick.last_practiced.strftime("(%b %e, %Y)")
    else
      "(no previous practice)"
    end
  end

  def scheduled_practice_date(lick)
    if lick.scheduled_practice
      lick.scheduled_practice.strftime("(%b %e, %Y)")
    else
      "(no practice scheduled)"
    end
  end

  def lick_url_and_method(lick, user)
    if lick.id
      {url: user_lick_url(user, lick), method: 'patch'}
    else
      {url: user_licks_url(@user)}
    end
  end

  def lick_submit_button(f, lick, user)
    if lick.id
      f.submit "Update Lick"
    else
      f.submit "Create Lick"
    end
  end
end
