module Api 
  module V1 
    class AccountsController < BaseController
      before_action :set_account, only: [:show, :update, :destroy]
      before_action :set_owner, only: [:index, :create]
      def index
        @accounts = @owner.accounts.all
        json_render(@accounts)
      end

      def show
        json_render(@account)
      end

      def create 
        @account = @owner.accounts.create!(account_params)
        if @account.valid? 
          json_render(@account, :created)
        else
          json_render(@account.errors, :unprocessable_entity)
        end
      end

      def update
        @account.update(acount_params)
        if @account.save? 
          json_render(@account, :accepted)
        else
          json_render(@account.errors, :unprocessable_entity)
        end
      end

      def destroy 
      end

      private 
        def set_account 
          @account = User.find(params[:user_id]).accounts.find(params[:id])
        end

        def set_owner 
          @owner = User.find(params[:user_id])
        end

        def account_params
          params.require(:account).permit( :user_id, :type_account, :amount)
        end
    end
  end
end