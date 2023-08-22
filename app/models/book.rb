# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :assemblies

  validates :published_at, presence: true
  validates :isbn, presence: true
  validate :isbn_valid?

  private

  def isbn_valid?
    errors.add(:isbn, "is invalid") unless ISBN.valid?(isbn)
  end
end
