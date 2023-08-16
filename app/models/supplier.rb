# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :parts, dependent: :destroy

  attr_readonly :account, :part

  validates :name, presence: true

  def account_with_digit
    return unless account

    [account.account_number, account.check_digit].compact.join(" - ")
  end
end
