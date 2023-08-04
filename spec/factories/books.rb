# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    published_at { FFaker::Time.date }
    author { Author.create(name: FFaker::Name.first_name) }
  end
end
