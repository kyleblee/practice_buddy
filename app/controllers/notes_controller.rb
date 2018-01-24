class NotesController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_user
end
