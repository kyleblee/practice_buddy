class NotesController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user

  def create
    binding.pry
  end
end
