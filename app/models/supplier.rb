# frozen_string_literal: true

class Supplier < ApplicationRecord
  validates :name, presence: true
end
