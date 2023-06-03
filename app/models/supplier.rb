# frozen_string_literal: true

class Supplier < ApplicationRecord
  validates_presence_of :name
end
