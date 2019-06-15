class EventpostcommentsController < ApplicationController

    before_action :set_eventpostcomment, only: [:like, :dislike]

    def create
      puts eventpostcomment_params
      @eventpostcomment = Eventpostcomment.new(eventpostcomment_params)
      @id_to_redirect = params.require(:eventpostcomment)["eventpost_id"]
      @urltoredirect = "/eventposts/" + @id_to_redirect

      respond_to do |format|
        if @eventpostcomment.save
          puts "wiiii, sí funcionó"
          format.html { redirect_to @urltoredirect, notice: 'Comment was successfully created.' }

        else
          puts "no funcionó"
          format.html { redirect_to @urltoredirect }
          format.json { render json: @eventpostcomment.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @id_to_redirect = params["eventpost_id"]
      @urltoredirect = "/eventposts/" + @id_to_redirect

      @eventpostcomment = Eventpostcomment.find(params["id"])
      @eventpostcomment.destroy
      respond_to do |format|
        format.html { redirect_to @urltoredirect, notice: 'Se ha eliminado el comentario' }
      end
    end

    # Cosas de los votos
    def like
      @eventpostcomment.liked_by current_user
      redirect_to @urltoredirect
    end

    def dislike
      @eventpostcomment.disliked_by current_user
      redirect_to @urltoredirect
    end

    private
      def eventpostcomment_params
        params.require(:eventpostcomment).permit(:user_id, :eventpost_id, :content, :rate)
      end

      def set_eventpostcomment
        @eventpostcomment = Eventpostcomment.find(params[:eventpostcommentid])
        @id_to_redirect = params["eventpost_id"]
        @urltoredirect = "/eventposts/" + @id_to_redirect
      end

  end
