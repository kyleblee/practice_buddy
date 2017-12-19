class LicksController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user

  def index
    @user = current_user
    @licks = Lick.filter_and_sort_licks(@user, params)
    # Need to add logic that accomodates if filters / sorts have been selected.
    # They are reaching params correctly now.
  end

  def new
    @lick = Lick.new
  end

  def create
    binding.pry
  end

  # {
  #   "utf8"=>"✓",
  #   "authenticity_token"=>"Rark3BuPDKa5+hOmAaO7eyJGGaxxBueOVpr+s0OmGYaZowjqb3itIRc9imipOXHIsB6FGbaPC5EvjG6K0LPaQw==",
  #   "lick"=>{
  #     "name"=>"fake name",
  #     "bpm"=>"",
  #     "current_key"=>"",
  #     "link"=>"",
  #     "artist_id"=>"",
  #     "artist"=>{"name"=>""},
  #     "tonalities"=>[""],
  #     "performance_rating"=>"",
  #     "last_practiced(1i)"=>"",
  #     "last_practiced(2i)"=>"",
  #     "last_practiced(3i)"=>"",
  #     "scheduled_practice(1i)"=>"",
  #     "scheduled_practice(2i)"=>"",
  #     "scheduled_practice(3i)"=>"",
  #     "description"=>""
  #   },
  #     "new_tonalities"=>["", ""],
  #     "commit"=>"Create Lick",
  #     "controller"=>"licks",
  #     "action"=>"create",
  #     "user_id"=>"2"
  #     } permitted: false>
end
