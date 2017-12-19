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
    @lick = Lick.new(lick_params)
    binding.pry
  end

  private

  def lick_params
    params.require(:lick).permit(:name, :bpm, :current_key, :link, :artist_id,
      {new_artist: [:name]}, :tonalities, {new_tonalities: [:name]}, :performance_rating,
      "last_practiced(1i)", "last_practiced(2i)", "last_practiced(3i)",
      "scheduled_practice(1i)", "scheduled_practice(2i)", "scheduled_practice(3i)", :description)
  end

 # {
 #   "utf8"=>"✓",
 #   "authenticity_token"=>"F9ECHndHab+P/GK5GfmfytZpEldIPUXYXyiIwBN+5SnL2O4oA7DIOCE7+3exY1V5RDGO4o+0qccmPhj5gGsm7A==",
 #   "lick"=> {
 #     "name"=>"",
 #     "bpm"=>"",
 #     "current_key"=>"",
 #     "link"=>"",
 #     "artist_id"=>"",
 #     "artist"=>{"name"=>""},
 #     "tonalities"=>[""],
 #     "new_tonalities"=>[{"name"=>""}, {"name"=>""}],
 #     "performance_rating"=>"",
 #     "last_practiced(1i)"=>"",
 #     "last_practiced(2i)"=>"",
 #     "last_practiced(3i)"=>"",
 #     "scheduled_practice(1i)"=>"",
 #     "scheduled_practice(2i)"=>"",
 #     "scheduled_practice(3i)"=>"",
 #     "description"=>""},
 #     "commit"=>"Create Lick",
 #     "controller"=>"licks",
 #     "action"=>"create",
 #     "user_id"=>"2"
 #     }
end
