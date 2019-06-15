class ClassroomcommentsController < ApplicationController

      before_action :set_classroomcomment, only: [:like, :dislike]

      def create
        puts classroomcomment_params
        @classroomcomment = Classroomcomment.new(classroomcomment_params)
        @id_to_redirect = params.require(:classroomcomment)["classroom_id"]
        @urltoredirect = "/classrooms/" + @id_to_redirect

        respond_to do |format|
          if @classroomcomment.save
            puts "wiiii, sí funcionó"
            format.html { redirect_to @urltoredirect, notice: 'Comment was successfully created.' }

          else
            puts "no funcionó"
            format.html { redirect_to @urltoredirect }
            format.json { render json: @classroomcomment.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @id_to_redirect = params["classroom_id"]
        @urltoredirect = "/classrooms/" + @id_to_redirect

        @classroomcomment = Classroomcomment.find(params["id"])
        @classroomcomment.destroy
        respond_to do |format|
          format.html { redirect_to @urltoredirect, notice: 'Se ha eliminado el comentario' }
        end
      end

      # Cosas de los votos
      def like
        @classroomcomment.liked_by current_user
        redirect_to @urltoredirect
      end

      def dislike
        @classroomcomment.disliked_by current_user
        redirect_to @urltoredirect
      end

      private
        def classroomcomment_params
          params.require(:classroomcomment).permit(:user_id, :classroom_id, :content, :rate)
        end

        def set_classroomcomment
          @classroomcomment = Classroomcomment.find(params[:classroomcommentid])
          @id_to_redirect = params["classroom_id"]
          @urltoredirect = "/classrooms/" + @id_to_redirect
        end

end
