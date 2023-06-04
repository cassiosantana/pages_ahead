# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_one :account, dependent: :destroy

  validates :name, presence: true
end
