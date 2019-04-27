class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index]
  def show
    @user = User.find(params[:id])
  end
  def index    
    if current_user
      @sheets = current_user.time_sheets
    else
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
  end

end
