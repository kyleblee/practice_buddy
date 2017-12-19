module LicksHelper
  def render_sorted_view(user, licks, params)
    if params[:sort] == "Tonality" || params[:sort] == "Artist"
      render partial: "sort_with_headers", locals: {user: user, licks: licks}
    else
      render partial: "sort_without_headers", locals: {user: user, licks: licks}
    end
  end
end
