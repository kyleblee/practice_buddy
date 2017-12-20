class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user

  def index
    @user = current_user
    @licks = Lick.filter_and_sort_licks(@user, params)
  end

  def new
    @lick = Lick.new
    2.times{@lick.tonalities.build}
  end

  def create
    @lick = @user.licks.create(clean_lick_params(lick_params))
    binding.pry
    if @lick.valid?
      redirect_to user_lick_url(@user, @lick)
    else
      render :new
    end
  end

  def show
    binding.pry
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
end
