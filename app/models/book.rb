# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :assemblies

  validates :published_at, presence: true
  validate :assembly_validity, if: -> { assembly_ids.present? }

  private

  def assembly_validity
    return unless Assembly.where(id: assembly_ids)
                          .pluck(:id) == assembly_ids&.map(&:to_i) || assembly_ids.nil?

    errors.add(:assembly_ids, "One or more assemblies not found.")
  end
end
