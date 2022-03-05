module Api 
  module V1 
    class MovementsController < BaseController
      def index 
        @movements = Movement.all
        json_render(@movements,'', :ok)
      end
      def create 
      end
      def charge
        account = Account.find(params[:account_id])
        
        if charge_limit?(params[:amount], account)
          movement =  Movement.create!(
                        account_id:params[:account_id], 
                        type_movement: 'charge', 
                        amount: params[:amount], 
                        description: params[:description]
                      ) 

          if movement.valid?
            Account.find(movement.account_id).update!(amount: Account.find(movement.account_id).amount - movement.amount)
            json_render(movement,'', :created)
          end
        else
          json_render(movement,'', :unprocessable_entity)
        end
      end

      def payment         
        movement =  Movement.create!(
                      :params[:account_id], 
                      type_movement: 'payment', 
                      amount: params[:amount], 
                      description: params[:description]
                    )

        if movement.valid?
          Account.find(movement.account_id).update!(amount: Account.find(movement.account_id).amount + movement.amount)
          json_render(movement,'', :created)
        else
          json_render(movement,'', :unprocessable_entity)
        end         
      end
      private
        def charge_limit?(amount, account)
          (account.is_credit? && amount < 1000) || (account.is_debit? && (account.amount - amount) > 0.01)          
        end
    end
  end
end