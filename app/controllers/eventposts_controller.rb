class EventpostsController < ApplicationController
  before_action :set_eventpost, only: [:show, :edit, :update, :destroy, :like, :dislike]

  # GET /eventposts
  # GET /eventposts.json
  def index
    @eventposts = Eventpost.all
  end

  # GET /eventposts/1
  # GET /eventposts/1.json
  def show
    @is_connected = current_user

    if @is_connected
      @isadmin = (current_user.has_role? :admin)
      @is_author = (current_user.id == @eventpost.user_id)
      @is_event_author = (current_user.id == @eventpost.event.user_id) # user_id == id del autor
      @eventpostcomment = Eventpostcomment.new
    end

    @postuser = @eventpost.user
    @postusercount = @postuser.posts.count + @postuser.eventposts.count
    @postuserscore = @postuser.posts.sum(:cached_votes_score) + @postuser.eventposts.sum(:cached_votes_score)

  end

  # GET /eventposts/new
  def new
    @is_subscriptor = Eventsubsription.exists?(:user_id => current_user.id, :event_id => params[:event_id])
    @eventpost = Eventpost.new
    @event = Event.find(params[:event_id])
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
    event = @eventpost.event
    @eventpost.destroy
    respond_to do |format|
      format.html { redirect_to event, notice: 'Eventpost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @eventpost.liked_by current_user
    redirect_to @eventpost
  end

  def dislike
    @eventpost.disliked_by current_user
    redirect_to @eventpost
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
