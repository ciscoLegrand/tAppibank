module Api 
  module V1 
    class BaseController < ActionController::Base 
      include Concerns::RescueHandler 

      def json_render(object, status = :ok)
        render json: object, status: status
      end
    end
  end
end