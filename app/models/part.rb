# frozen_string_literal: true

class Part < ApplicationRecord
  belongs_to :supplier
  has_and_belongs_to_many :assemblies

  validates :part_number, presence: true
end
