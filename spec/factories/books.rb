# frozen_string_literal: true

require "isbn_generator"

FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    published_at { FFaker::Time.date }
    isbn { IsbnGenerator.isbn_thirteen }
    author { create(:author) }
  end
end
