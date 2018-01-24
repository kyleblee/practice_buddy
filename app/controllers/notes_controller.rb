class NotesController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
  layout false

  def new

  end

  def create
    binding.pry
  end
end
