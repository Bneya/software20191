class ModrequestsController < ApplicationController
  before_action :set_modrequest, only: [:show, :edit, :update, :destroy, :accept, :reject]

  # GET /modrequests
  # GET /modrequests.json
  def index
    @modrequests = Modrequest.all
  end

  # GET /modrequests/1
  # GET /modrequests/1.json
  def show
  end

  # GET /modrequests/new
  def new
    @modrequest = Modrequest.new
  end

  # GET /modrequests/1/edit
  def edit
  end

  # POST /modrequests
  # POST /modrequests.json
  def create
    @modrequest = Modrequest.new(modrequest_params)
    respond_to do |format|
      if @modrequest.save
        format.json { render :show, status: :created, location: @modrequest }
      else
        format.html { render :new }
        format.json { render json: @modrequest.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create_new
    Modrequest.create(user_id: params[:user_id], course_id: params[:course_id])
    redirect_to course_path(course_id)
  end

  def accept
    puts params
    @u = User.find(@modrequest.user_id)
    @u.add_role :mod, Course.find(@modrequest.course_id)
    redirect_to modrequests_path
  end

  def reject
    puts 'aaaaaaaaaaaaa'
    puts params
    redirect_to modrequests_path

  end


  
  # PATCH/PUT /modrequests/1
  # PATCH/PUT /modrequests/1.json
  def update
    respond_to do |format|
      if @modrequest.update(modrequest_params)
        format.html { redirect_to Course.find(@modrequest.course_id), notice: 'Modrequest was successfully updated.' }
        format.json { render :show, status: :ok, location: @modrequest }
      else
        format.html { render :edit }
        format.json { render json: @modrequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modrequests/1
  # DELETE /modrequests/1.json
  def destroy
    @modrequest.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modrequest
      @modrequest = Modrequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modrequest_params
      params.require(:modrequest).permit(:user_id, :course_id)
    end
end
