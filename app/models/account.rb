# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier

  validate :validate_single_account
  validates :account_number, presence: true

  private

  def validate_single_account
    if supplier_id && Account.exists?(supplier_id: supplier_id)
      errors.add(:supplier, "already has an associated account")
    end
  end
end
