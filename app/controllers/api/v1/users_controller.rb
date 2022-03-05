module Api 
  module V1 
    class UsersController < BaseController
      before_action :set_user, only: [:show]
      def index
        @users = User.all
        json_render(@users)
      end

      def show 
        json_render(@user)
      end

      def register
        @user = User.create(user_params)
        @user.update!(password_digest: BCrypt::Password.create(@user.password_digest))
        if @user.valid? 
          token = encoded_token({user_id: @user.id})
          json_render(@user, token, :created)
        else
          json_render(@user.errors, token, :unprocessable_entity)
        end
      end

      def login 
        @user = User.find_by(dni: params[:dni]) 
        if @user && @user.authenticate(params[:password])
          token = encoded_token({user_id: @user.id})
          json_render(@user, token)
        else
          head :unauthorized
        end
      end 

      private 
        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit( :name, :last_name, :dni, :password)
        end
    end
  end
end
