# frozen_string_literal: true

class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :books

  validates :name, presence: true
end
