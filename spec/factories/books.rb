# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    published_at { FFaker::Time.date }
    author { nil }
  end
end
