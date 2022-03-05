module Api 
  module V1 
    module Concerns::RescueHandler 
      extend ActiveSupport::Concern
      
      included do   
        rescue_from ActionController::ParameterMissing do |error| 
          render json: { message: error.message }, status: :bad_request 
        end

        rescue_from ActiveRecord::RecordNotFound do |error|
          render json: { message: error.message }, status: :not_found
        end

        rescue_from ArgumentError do |error| 
          render json: { message: error.message }, status: :bad_request
        end
      
        rescue_from StandardError do |error|
          render json: { message: error.message }, status: :unprocessable_entity
        end
      end 
    end 
  end
end