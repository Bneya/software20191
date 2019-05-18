class EventpostsController < ApplicationController
  before_action :set_eventpost, only: [:show, :edit, :update, :destroy]

  # GET /eventposts
  # GET /eventposts.json
  def index
    @eventposts = Eventpost.all
  end

  # GET /eventposts/1
  # GET /eventposts/1.json
  def show
  end

  # GET /eventposts/new
  def new
    @eventpost = Eventpost.new
  end

  # GET /eventposts/1/edit
  def edit
  end

  # POST /eventposts
  # POST /eventposts.json
  def create
    @eventpost = Eventpost.new(eventpost_params)

    respond_to do |format|
      if @eventpost.save
        format.html { redirect_to @eventpost, notice: 'Eventpost was successfully created.' }
        format.json { render :show, status: :created, location: @eventpost }
      else
        format.html { render :new }
        format.json { render json: @eventpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventposts/1
  # PATCH/PUT /eventposts/1.json
  def update
    respond_to do |format|
      if @eventpost.update(eventpost_params)
        format.html { redirect_to @eventpost, notice: 'Eventpost was successfully updated.' }
        format.json { render :show, status: :ok, location: @eventpost }
      else
        format.html { render :edit }
        format.json { render json: @eventpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventposts/1
  # DELETE /eventposts/1.json
  def destroy
    @eventpost.destroy
    respond_to do |format|
      format.html { redirect_to eventposts_url, notice: 'Eventpost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eventpost
      @eventpost = Eventpost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eventpost_params
      params.require(:eventpost).permit(:title, :user_id, :event_id, :content, :rate)
    end
end
