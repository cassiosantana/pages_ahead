# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier

  validates :account_number, presence: true, unless: -> { supplier.account.present? }
  validate :account_number_immutable, on: :update

  validates :supplier_id, uniqueness: { message: "already has an associated account" }

  private

  def account_number_immutable
    if account_number_changed?
      errors.add(:account_number, "cannot be changed")
    end
  end
end
