# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :supplier

  validates :account_number, presence: true
end
