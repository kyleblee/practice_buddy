class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
  before_action :tonalities_for_form, only: [:new, :edit, :create, :update]

  def index
    @user = current_user
    @licks = Lick.filter_and_sort_licks(@user, params)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @licks }
    end
  end

  def new
    @lick = Lick.new
  end

  def create
    @lick = @user.licks.create(lick_params)
    if @lick.valid?
      flash[:message] = "New lick created!"
      redirect_to user_lick_url(@user, @lick)
    else
      render :new
    end
  end

  def show
    @lick = Lick.find_by(id: params[:id])
    cant_find_lick_redirect if !@lick
  end

  def edit
    if @lick = Lick.find_by(id: params[:id])
      render :edit
    else
      cant_find_lick_redirect
    end
  end

  def update
    if @lick = Lick.find_by(id: params[:id])
      if @lick.update(lick_params)
        flash[:message] = "Lick updated!"
        redirect_to user_lick_url(@user, @lick)
      else
        render :edit
      end
    else
      cant_find_lick_redirect
    end
  end

  def destroy
    if @lick = Lick.find_by(id: params[:id])
      @lick.destroy
      flash[:message] = "Lick deleted!"
    else
      flash[:message] = "Hmm, we can't seem to find that lick."
    end
    redirect_to user_licks_url(@user)
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

  def cant_find_lick_redirect
    flash[:message] = "Hmm, we can't seem to find that lick."
    redirect_to user_licks_url(@user)
  end
end
