class Account < ApplicationRecord
  belongs_to :user

  has_many :users
  has_many :movements

  TYPE_ACCOUNT = ['credito', 'debito']

  def is_debit?
    self.type_account == TYPE_ACCOUNT[1]
  end

  def is_credit?
    self.type_account == TYPE_ACCOUNT[0]
  end
end
