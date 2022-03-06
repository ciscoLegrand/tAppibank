class Movement < ApplicationRecord
  belongs_to :account

  validates_presence_of :type_movement, :amount, :description

  TYPE_MOVEMENT = ['charge', 'payment']

  def is_valid_movement? 
    TYPE_MOVEMENT.include?(self.type_movement)
  end
end
