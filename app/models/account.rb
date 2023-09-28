# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier

  before_save :assign_check_digit

  validates :account_number, presence: true
  validates :supplier_id, uniqueness: { message: "already has an associated account" }
  validate :account_number_not_updated, :supplier_id_not_updated, on: :update

  attr_readonly :account_number, :supplier_id

  def number_with_digit
    [account_number, check_digit].compact.join(" - ")
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[account_number]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["supplier"]
  end

  private

  def assign_check_digit
    self.check_digit = Accounts::CheckDigitCalculator.call(account_number)
  end

  def account_number_not_updated
    errors.add(:account_number, "cannot be updated") if account_number_changed?
  end

  def supplier_id_not_updated
    errors.add(:supplier_id, "cannot be updated") if supplier_id_changed?
  end
end
