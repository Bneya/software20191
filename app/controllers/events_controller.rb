class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :suscribe, :desuscribe]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @is_connected = current_user
    if @is_connected
      @is_admin = (current_user.has_role? :admin)
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @is_connected = current_user
    if @is_connected
      @is_admin = (current_user.has_role? :admin)
      @is_subscriptor = Eventsubsription.exists?(event_id: @event.id, user_id: current_user.id)
      @is_author = current_user.id.to_i == @event.user_id.to_i
    else
      @is_admin = false
      @is_subscriptor = false
      @is_author = false
    end
    @event_full = Eventsubsription.where(event_id: @event.id).count >= @event.max_users.to_i
    @event_count = Eventsubsription.where(event_id: @event.id).count
    date = Date.strptime("December 31, 2018", "%B %d, %Y")
    @date_text = date + @event.day.to_i
    @modules =  ["[8:30-09:50]","[10:00-11:20]","[11:30-12:50]","[13:00-13:50]","[14:00-15:20]","[15:30-16:50]","[17:00-18:20]","[18:30-19:50]"]
    if @event.user.realname == nil
      @author_name = @event.user.username
    else
      @author_name = @event.user.realname
    end
    if @event.event_type != "Evento Externo"
      @course = Course.find(@event.course_id)
      @course_name = Course.find(@event.course_id).name
      @course_sub = Suscription.exists?(course_id: @course.id, user_id: current_user.id, sbtype: "alumno")
    end

    if @event.event_type == "Buscar Profesor Particular" || @event.event_type == "Clases Particulares" ||
      @teacher = nil
      @teacher_name = "No asignado"
      if @is_connected
        @is_teacher = Suscription.exists?(course_id: @course.id, user_id: current_user.id, sbtype: "teacher")
      end
      Suscription.where(course_id: @course.id, sbtype: "teacher").each do |sub|
        if Eventsubsription.exists?(event_id: @event.id, user_id: sub.user_id)
          @teacher = User.find(sub.user_id)
          if @teacher.realname == nil
            @teacher_name = @teacher.username
          else
            @teacher_name = @teacher.realname
          end
        end
      end



    end


  end

  # GET /events/new
  def new
    @user = current_user
    @event = Event.new
    @available_forms = { "Grupo de Estudio" => "form_ge", "Clases Particulares" => "form_cp", "Buscar Profesor Particular" => "form_bc", "Evento Externo" => "form_ext" }
    @form_file = @available_forms[params[:event_type]]
    if @user.realname == nil
      @user_name = @user.username
    else
      @user_name = @user.realname
    end

    @classroom  = Classroom.find(params[:classroom_id])
    @modules =  ["[8:30-09:50]","[10:00-11:20]","[11:30-12:50]","[13:00-13:50]","[14:00-15:20]","[15:30-16:50]","[17:00-18:20]","[18:30-19:50]"]
    @schedule = params[:schedule]
    @day = params[:day]
    date = Date.strptime("December 31, 2018", "%B %d, %Y")
    @date_text = date + params[:day].to_i
    @courses = Course.all.collect {|c| c if Suscription.exists?(:user_id => @user.id, :course_id => c.id, :sbtype => "alumno") }.compact
    @courses_as_teacher = Course.all.collect {|c| c if Suscription.exists?(:user_id => @user.id, :course_id => c.id, :sbtype => "teacher") }.compact
  end

  # GET /events/1/edit
  def edit
    @available_forms = { "Grupo de Estudio" => "form_ge", "Clases Particulares" => "form_cp", "Buscar Profesor Particular" => "form_bc", "Evento Externo" => "form_ext" }

    if (current_user.has_role? :admin)
      @user = User.find(@event.user_id)
      @form_file = "form_admin"
    else
      @user = current_user
      @form_file = @available_forms[@event.event_type]
    end

    if @user.realname == nil
      @user_name = @user.username
    else
      @user_name = @user.realname
    end

    @classroom = Classroom.find(@event.classroom_id)
    @classrooms = Classroom.all
    @modules =  ["[8:30-09:50]","[10:00-11:20]","[11:30-12:50]","[13:00-13:50]","[14:00-15:20]","[15:30-16:50]","[17:00-18:20]","[18:30-19:50]"]
    @schedule = @event.schedule
    @day = @event.day
    date = Date.strptime("December 31, 2018", "%B %d, %Y")
    @date_text = date + @event.day.to_i
    @courses = Course.all.collect {|c| c if Suscription.exists?(:user_id => @user.id, :course_id => c.id, :sbtype => "alumno") }.compact
    @courses_as_teacher = Course.all.collect {|c| c if Suscription.exists?(:user_id => @user.id, :course_id => c.id, :sbtype => "teacher") }.compact
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        Eventsubsription.create(user_id: event_params[:user_id], event_id: @event.id)
        format.html { redirect_to @event, notice: 'Event was successfully created.'}
        format.json { render :show, status: :created, location: @event }
      else
        # format.html { render :new }
        format.html { redirect_to new_event_path(event_params),
                      :alert => @event.errors.map { |k, v| "%s: %s" % [k.to_s, v.to_s] } }
        # format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @classroom  = Classroom.find(@event.classroom_id)
    @modules =  ["[8:30-09:50]","[10:00-11:20]","[11:30-12:50]","[13:00-13:50]","[14:00-15:20]","[15:30-16:50]","[17:00-18:20]","[18:30-19:50]"]
    date = Date.strptime("December 31, 2018", "%B %d, %Y")
    @date_text = date + @event.day.to_i
    @courses = Course.all.collect {|c| c if Suscription.exists?(:user_id => current_user.id, :course_id => c.id, :sbtype => "alumno") }.compact
    @courses_as_teacher = Course.all.collect {|c| c if Suscription.exists?(:user_id => current_user.id, :course_id => c.id, :sbtype => "teacher") }.compact
    if (current_user.has_role? :admin)
      ep = event_params
      ep[:day] = Date.strptime(event_params[:day], "%Y-%m-%d").yday.to_s
    else
      ep = event_params
    end
    respond_to do |format|
      if @event.update(ep)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        # format.html { render :edit }
        format.html { redirect_to edit_event_path(ep),
                      :alert => @event.errors.map { |k, v| "%s: %s" % [k.to_s, v.to_s] } }

        # format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to schedule_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def suscribe
    Eventsubsription.create(user_id: params[:user_id], event_id: params[:id])
    redirect_to @event, {:day => params[:day], :course => params[:course]}
  end

  def desuscribe
    Eventsubsription.where(user_id: params[:user_id], event_id: params[:id]).destroy_all
    redirect_to @event, {:day => params[:day], :course => params[:course]}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :classroom_id, :course_id, :schedule, :day, :event_type, :user_id, :max_users, :price)
    end
end
