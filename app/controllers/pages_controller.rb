class PagesController < ApplicationController

  def home
    @day = Time.now.yday
  end
  def get_users
    @users = User.all
  end
  def index
    if current_user
      @sheets = current_user.time_sheets
    else
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
  end
  def schedule
    if params.key?(:day) && params[:day].to_i > Date.strptime(Time.now.strftime("%B %d, %Y"), "%B %d, %Y").yday
      Date.strptime(Time.now.strftime("%B %d, %Y"), "%B %d, %Y")
      date = Date.strptime("December 31, 2018", "%B %d, %Y")
      @date_text = date + params[:day].to_i
      @day = params[:day]
    else
      @date_text = Date.strptime(Time.now.strftime("%B %d, %Y"), "%B %d, %Y")
      @day = @date_text.yday.to_s
    end

    if params.key?(:campus_id)
      @classroom_list = Classroom.where(campus_id: params[:campus_id])
      @campus = Campus.find(params[:campus_id])
    else
      @campus = Campus.find("1")
      @classroom_list = Classroom.where(campus_id: @campus.id.to_s)
    end

    @is_connected = current_user
    @is_admin = (current_user.has_role? :admin) if @is_connected else false
    if @is_connected
      @is_alumno = Suscription.where(user_id: current_user.id, sbtype: "alumno").count > 0
      @is_teacher = Suscription.exists?(:user_id => current_user.id, :sbtype => "teacher")
    else
      @is_teacher = false
    end
  end
end
