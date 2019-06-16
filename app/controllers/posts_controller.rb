class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :dislike]

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.all
    @cursos = Course.all

    @posts = Post.where(nil)

    @posts = @posts.course_id(params[:course_id]) if (params[:course_id].present? && params[:course_id] != '0')
    # @posts = @posts.contains(params[:contains]) if params[:contains].present?
    @posts = @posts.where('title like ?', '%' + params[:intitle] + '%') if params[:intitle].present?
    @posts = @posts.where('content like ?', '%' + params[:incontent] + '%') if params[:incontent].present?
    @posts = @posts.order(cached_votes_up: :desc)
    # @posts = Post.filter(params.slice(:course_id))

    puts "lo que sale de index"
    puts @posts

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @postcomment = Postcomment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def save_post
    SavedPost.create(user_id: params[:user_id], post_id: params[:post_id])
    #redirect_to post_path(params[:post_id])
    respond_to do |format|
      format.html {redirect_to Post.find(params[:post_id]), notice: "Post was successfully saved"}
      format.json {render :show, status: :ok, location: post} #redirect_to Course.find(params[:course_id])
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Cosas de los votos
  def like
    @post.liked_by current_user
    redirect_to @post
  end

  def dislike
    @post.disliked_by current_user
    redirect_to @post
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :course_id, :content, :title, :rate)
    end
end
