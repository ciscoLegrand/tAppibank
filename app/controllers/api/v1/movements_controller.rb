module Api 
  module V1 
    class MovementsController < BaseController
      before_action :set_user, only: %i[index create]
      before_action :set_account, only: %i[charge payment create]

      def index 
        movements = @user.accounts.find(params[:account_id]).movements.all
        total = @user.accounts.find(params[:account_id]).amount
        result = [total: total.to_f, movements: movements]
        json_render(result)
      end

      def create 
      end
      
      def charge        
        if charge_limit?(params[:amount], @account)
          create_movement 
          if @movement.is_valid_movement?
            @movement.save 
            @account.update!(amount: @account.amount - @movement.amount)
          end
        end

        json_render(@account.movements.find(@movement.id))
      end

      def payment        
        if charge_limit?(params[:amount], @account)
          create_movement 
          if @movement.is_valid_movement?
            @movement.save 
            @account.update!(amount: @account.amount + @movement.amount)
          end
        end

        json_render(@account.movements.find(@movement.id))
      end

      private
        
        def set_user 
          @user = User.find(params[:user_id])
        end
        def set_account 
          @account = Account.find(params[:account_id])
        end
        def charge_limit?(amount, account)
          (account.is_credit? && amount < 1000) || (account.is_debit? && (account.amount - amount) > 0.01)          
        end

        def create_movement
          @movement = Movement.new(
            account_id: params[:account_id], 
            type_movement: params[:type_movement], 
            amount: params[:amount], 
            description: params[:description]
          )      
        end
    end
  end
end