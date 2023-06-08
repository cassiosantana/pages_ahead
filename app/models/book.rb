# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author

  validates :published_at, presence: true
end
