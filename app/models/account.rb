# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier

  validates :account_number, presence: true

  attr_readonly :account_number, :supplier_id

  validates :supplier_id, uniqueness: { message: "already has an associated account" }
end
