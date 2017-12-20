class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
  before_action :tonalities_for_form, only: [:new, :edit]

  def index
    @user = current_user
    @licks = Lick.filter_and_sort_licks(@user, params)
  end

  def new
    @lick = Lick.new
  end

  def create
    @lick = @user.licks.create(clean_lick_params(lick_params))
    if @lick.valid?
      redirect_to user_lick_url(@user, @lick)
    else
      render :new
    end
  end

  def show
    binding.pry
  end

  def edit
    if @lick = Lick.find_by(id: params[:id])
      render :edit
    else
      flash[:message] = "Hmm, it doesn't seem like you have a lick like that yet."
      redirect_to user_licks_url(@user)
    end
  end

  private

  def lick_params
    params.require(:lick).permit(:name, :bpm, :current_key, :link, :artist_id,
      {new_artist: [:name]}, {tonality_ids: []}, {new_tonalities: [:name]}, :performance_rating,
      "last_practiced(1i)", "last_practiced(2i)", "last_practiced(3i)", "scheduled_practice(1i)",
      "scheduled_practice(2i)", "scheduled_practice(3i)", :description)
  end

  def clean_lick_params(lick_params)
    lick_params.reject do |k,v|
      if k == "tonality_ids"
        v.delete("")
        v.empty?
      else
        v.blank?
      end
    end
  end

  def tonalities_for_form
    @tonalities = [Tonality.new, Tonality.new]
  end
end
