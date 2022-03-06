class Account < ApplicationRecord
  belongs_to :user

  has_many :movements, dependent: :destroy

  TYPE_ACCOUNT = ['credito', 'debito']

  def is_valid_account?(type_account)
    TYPE_ACCOUNT.include?(type_account.downcase)
  end

  def is_debit?
    self.type_account == TYPE_ACCOUNT[1]
  end

  def is_credit?
    self.type_account == TYPE_ACCOUNT[0]
  end
end
