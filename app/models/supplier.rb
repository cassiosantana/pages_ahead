# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :parts, dependent: :destroy

  attr_readonly :account, :part

  validates :name, presence: true
  validates :cnpj, presence: true
  validate :cnpj_valid?

  def account_with_digit
    return unless account

    [account.account_number, account.check_digit].compact.join(" - ")
  end

  private

  def cnpj_valid?
    errors.add(:cnpj, "is invalid") unless CNPJ.valid?(cnpj)
  end
end
