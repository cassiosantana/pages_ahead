# frozen_string_literal: true

class Part < ApplicationRecord
  belongs_to :supplier
  has_and_belongs_to_many :assemblies

  attr_readonly :supplier_id

  validates :part_number, presence: true
  validate :supplier_id_not_updated, on: :update

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[assemblies supplier]
  end

  private

  def supplier_id_not_updated
    errors.add(:supplier_id, "cannot be updated") if supplier_id_changed?
  end
end
