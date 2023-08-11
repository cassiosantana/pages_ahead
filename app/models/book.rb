# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :assemblies

  validates :published_at, presence: true
end
