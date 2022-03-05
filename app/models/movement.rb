class Movement < ApplicationRecord
  belongs_to :account

  validates_presence_of :type_movement, :amount, :description

  TYPE_MOVEMENT = ['charge', 'payment']
end
