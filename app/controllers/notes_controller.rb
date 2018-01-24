class NotesController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
  layout false

  def new

  end

  def create
    binding.pry
    @lick = Lick.find_by(id: params["lick_id"].to_i)
    @note = @lick.notes.build(note_params)
    if @note.save
      flash[:message] = "New lick created!"
      binding.pry #need to create serializer
      render json: @note
    else
      binding.pry #need to come up with graceful error handling (use status code 400?)
    end
  end

  private

  def note_params
    params.permit(:lick_id, :user_id, :content)
  end
end
