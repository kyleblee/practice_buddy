class NotesController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
  layout false

  def new

  end

  def create
    @lick = Lick.find_by(id: params["lick_id"].to_i)
    @note = @lick.notes.build(note_params)
    if @note.save
      render json: @note, status: 201
    else
      render json: @note, status: 400
    end
  end

  private

  def note_params
    params.permit(:lick_id, :user_id, :content)
  end
end
