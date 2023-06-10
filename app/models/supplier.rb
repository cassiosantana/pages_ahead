# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :parts, dependent: :destroy

  validates :name, presence: true
end
