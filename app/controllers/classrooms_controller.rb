class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :like_noise, :dislike_noise, :like_disponibility, :dislike_disponibility, :like_sockets, :dislike_sockets]


  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = Classroom.all
    @is_connected = current_user
    if @is_connected
      @is_admin = (current_user.has_role? :admin)
    end



  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @is_connected = current_user

    if @is_connected
      @isadmin = (current_user.has_role? :admin)
      @classroomcomment = Classroomcomment.new
    end
    # @event.day.to_i < Date.strptime(Time.now.strftime("%B %d, %Y"), "%B %d, %Y").yday
    @actual_day = Date.strptime(Time.now.strftime("%B %d, %Y"), "%B %d, %Y").yday
    @available_events = @classroom.events.where("day >= %d" % [@actual_day])
    @noise_like = @classroom.get_upvotes vote_scope: "noise"
    @noise_dislike = @classroom.get_downvotes vote_scope: "noise"
    @disponibility_like = @classroom.get_upvotes vote_scope: "disponibility"
    @disponibility_dislike = @classroom.get_downvotes vote_scope: "disponibility"
    @sockets_like = @classroom.get_upvotes vote_scope: "sockets"
    @sockets_dislike = @classroom.get_downvotes vote_scope: "sockets"
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
    @campuses = Campus.all
  end

  # GET /classrooms/schedule
  def schedule
    @classrooms = Classroom.find_by(campus_id: params[:course].campus_id)
  end

  # GET /classrooms/1/edit
  def edit
    @campuses = Campus.all
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Cosas de los votos
  def like_noise
    @classroom.liked_by current_user, vote_scope: "noise"
    redirect_to @classroom
  end
  def dislike_noise
    @classroom.disliked_by current_user, vote_scope: "noise"
    redirect_to @classroom
  end

  def like_disponibility
    @classroom.liked_by current_user, vote_scope: "disponibility"
    redirect_to @classroom
  end
  def dislike_disponibility
    @classroom.disliked_by current_user, vote_scope: "disponibility"
    redirect_to @classroom
  end

  def like_sockets
    @classroom.liked_by current_user, vote_scope: "sockets"
    redirect_to @classroom
  end
  def dislike_sockets
    @classroom.disliked_by current_user, vote_scope: "sockets"
    redirect_to @classroom
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:title, :ubication, :campus_id)
    end
end
