# frozen_string_literal: true

class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
  has_and_belongs_to_many :books

  validates :name, presence: true

  def total_cost
    parts.sum(&:price)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[parts books]
  end
end
