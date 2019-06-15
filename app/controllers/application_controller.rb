      class ApplicationController < ActionController::Base
        before_action :configure_permitted_parameters, if: :devise_controller?

        def authenticate_admin!
          redirect_to new_user_session_path unless (current_user && current_user.has_role?(:admin))
        end

        protected

        def configure_permitted_parameters
          # Permit the `subscribe_newsletter` parameter along with the other
          # sign up parameters.
          devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:realname, :email, :password)}
          devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:realname, :bio, :email, :password, :current_password)}
        end
      end
