class PostcommentsController < ApplicationController

  before_action :set_postcomment, only: [:like, :dislike]

  def create
    puts postcomment_params
    @postcomment = Postcomment.new(postcomment_params)
    @id_to_redirect = params.require(:postcomment)["post_id"]
    @urltoredirect = "/posts/" + @id_to_redirect

    respond_to do |format|
      if @postcomment.save
        puts "wiiii, sí funcionó"
        format.html { redirect_to @urltoredirect, notice: 'Comment was successfully created.' }

      else
        puts "no funcionó"
        format.html { redirect_to @urltoredirect }
        format.json { render json: @postcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @id_to_redirect = params["post_id"]
    @urltoredirect = "/posts/" + @id_to_redirect

    @postcomment = Postcomment.find(params["id"])
    @postcomment.destroy
    respond_to do |format|
      format.html { redirect_to @urltoredirect, notice: 'Se ha eliminado el comentario' }
    end
  end

  # Cosas de los votos
  def like
    @postcomment.liked_by current_user
    redirect_to @urltoredirect
  end

  def dislike
    @postcomment.disliked_by current_user
    redirect_to @urltoredirect
  end

  private
    def postcomment_params
      params.require(:postcomment).permit(:user_id, :post_id, :content, :rate)
    end

    def set_postcomment
      @postcomment = Postcomment.find(params[:postcommentid])
      @id_to_redirect = params["post_id"]
      @urltoredirect = "/posts/" + @id_to_redirect
    end

end
