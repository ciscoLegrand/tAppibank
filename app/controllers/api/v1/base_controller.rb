module Api 
  module V1 
    class BaseController < ActionController::Base 
      include Concerns::RescueHandler 

      # before_action :authenticate_user, except: %i[index register login]

      def json_render(object, token = '', status = :ok)
        render json: {"#{object}": object,token: token}, status: status
      end

      private 
        SECRET = Rails.application.secrets.secret_key_base.to_s 

        def autenticate  
          authenticate_user || unauthorized 
        end 

        def authenticate_user 
          if decoded_token
            @user = User.find(decoded_token[0]['user_id'])
          end
        end

        def unhautorize 
          head :unauthorized
        end

        def encoded_token(payload)
          JWT.encode(payload, SECRET)
        end

        def auth_header 
          request.headers['Authorization']
        end

        def decoded_token 
          if auth_header 
            token = auth_header.split(' ').last
            begin
              JWT.decode(token, SECRET, true, algorithm: 'HS256')
            rescue JWT::DecodeError
              nil
            end
          end
        end
    end
  end
end