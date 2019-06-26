class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :suscribe, :desuscribe]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def suscribe
    Suscription.create(user_id: params[:user_id], course_id: params[:id], sbtype: params[:sbtype])
    redirect_to @course
  end

  def desuscribe
    Suscription.where(user_id: params[:user_id], course_id: params[:id], sbtype: params[:sbtype]).destroy_all
    redirect_to @course
  end


  def modrequest
      Modrequest.create(user_id: params[:user_id], course_id: params[:course_id])
      respond_to do |format|
        format.html {redirect_to Course.find(params[:course_id]), notice: "Mod Request was successfully sent"}
        format.json {render :show, status: :ok, location: @course} #redirect_to Course.find(params[:course_id])
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :campus_id, :description)
    end
end
