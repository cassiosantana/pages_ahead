# frozen_string_literal: true

require "isbn_generator"

FactoryBot.define do
  factory :book do
    published_at { FFaker::Time.date }
    isbn { IsbnGenerator.isbn_thirteen }
    author { create(:author) }
  end
end
