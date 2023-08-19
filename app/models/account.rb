# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier

  before_save :assign_check_digit

  validates :account_number, presence: true

  attr_readonly :account_number, :supplier_id

  validates :supplier_id, uniqueness: { message: "already has an associated account" }

  validate :account_number_not_updated, :supplier_id_not_updated, on: :update

  def number_with_digit
    [account_number, check_digit].compact.join(" - ")
  end

  private

  def assign_check_digit
    self.check_digit = AccountServices::CheckDigitCalculatorService.call(account_number)
  end

  def account_number_not_updated
    errors.add(:account_number, "cannot be updated") if account_number_changed?
  end

  def supplier_id_not_updated
    errors.add(:supplier_id, "cannot be updated") if supplier_id_changed?
  end
end
