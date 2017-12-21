class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
  before_action :tonalities_for_form, only: [:new, :edit, :create]

  def index
    @user = current_user
    @licks = Lick.filter_and_sort_licks(@user, params)
  end

  def new
    @lick = Lick.new
  end

  def create
    @lick = @user.licks.create(lick_params)
    if @lick.valid?
      redirect_to user_lick_url(@user, @lick)
    else
      render :new
    end
  end

  def show
    @lick = Lick.find_by(id: params[:id])
  end

  def edit
    if @lick = Lick.find_by(id: params[:id])
      render :edit
    else
      flash[:message] = "Hmm, it doesn't seem that you have a lick like that yet."
      redirect_to user_licks_url(@user)
    end
  end

  def update
    if @lick = Lick.find_by(id: params[:id])
      if @lick.update(lick_params)
        redirect_to user_lick_url(@user, @lick)
      else
        render :edit
      end
    else
      flash[:message] = "Hmm, we can't seem to find that lick."
      redirect_to user_licks_url(@user)
    end
  end

  private

  def lick_params
    params.require(:lick).permit(:name, :bpm, :current_key, :link, :artist_id,
      {new_artist: [:name]}, {tonality_ids: []}, {new_tonalities: [:name]}, :performance_rating,
      "last_practiced(1i)", "last_practiced(2i)", "last_practiced(3i)", "scheduled_practice(1i)",
      "scheduled_practice(2i)", "scheduled_practice(3i)", :description, {backing_track_ids: []},
      {new_backing_track: [:name, :link]})
  end

  def tonalities_for_form
    @tonalities = [Tonality.new, Tonality.new]
  end
end
