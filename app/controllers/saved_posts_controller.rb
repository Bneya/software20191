class SavedPostsController < ApplicationController
  before_action :set_saved_post, only: [:show, :edit, :update, :destroy]

  # GET /saved_posts
  # GET /saved_posts.json
  def index
    @saved_posts = SavedPost.all
  end

  # GET /saved_posts/1
  # GET /saved_posts/1.json
  def show
  end

  # GET /saved_posts/new
  def new
    @saved_post = SavedPost.new
  end

  # GET /saved_posts/1/edit
  def edit
  end

  # POST /saved_posts
  # POST /saved_posts.json
  def create
    @saved_post = SavedPost.new(saved_post_params)

    respond_to do |format|
      if @saved_post.save
        format.html { redirect_to @saved_post, notice: 'Saved post was successfully created.' }
        format.json { render :show, status: :created, location: @saved_post }
      else
        format.html { render :new }
        format.json { render json: @saved_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_new
    SavedPost.create(user_id: params[:user_id], post_id: params[:post_id])
    redirect_to post_path(params[:post_id])
  end


  # PATCH/PUT /saved_posts/1
  # PATCH/PUT /saved_posts/1.json
  def update
    respond_to do |format|
      if @saved_post.update(saved_post_params)
        format.html { redirect_to @saved_post, notice: 'Saved post was successfully updated.' }
        format.json { render :show, status: :ok, location: @saved_post }
      else
        format.html { render :edit }
        format.json { render json: @saved_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_posts/1
  # DELETE /saved_posts/1.json
  def destroy
    @saved_post.destroy
    respond_to do |format|
      format.html { redirect_to saved_posts_url, notice: 'Saved post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_post
      @saved_post = SavedPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saved_post_params
      params.require(:saved_post).permit(:user_id, :post_id)
    end
end
