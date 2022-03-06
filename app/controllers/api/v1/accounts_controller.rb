module Api 
  module V1 
    class AccountsController < BaseController
      before_action :set_account, only: %i[show update destroy]
      before_action :set_owner, only: %i[index create]
      def index
        @accounts = @owner.accounts.all
        json_render(@accounts)
      end

      def show
        json_render(@account)
      end

      def create 
        @account = Account.new(account_params)
        if @account.is_valid_account?(@account.type_account)
          @account = @owner.accounts.create!(account_params)
        end
        json_render(@account)
      end

      def update
        @account.update!(account_params) 
        json_render(@account)
      end

      def destroy 
        @account.destroy
        json_render(@account)
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