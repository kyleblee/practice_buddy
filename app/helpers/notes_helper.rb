module NotesHelper
  def format_date(date)
    formated_date = date.try(:strftime, "%m/%d/%Y")
  end
end
