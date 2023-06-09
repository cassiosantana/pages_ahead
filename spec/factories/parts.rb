# frozen_string_literal: true

FactoryBot.define do
  factory :part do
    part_number { "MyString" }
    supplier { nil }
  end
end
