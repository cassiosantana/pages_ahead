# frozen_string_literal: true

FactoryBot.define do
  factory :part do
    part_number { FFaker::Random.rand(1..99_999).to_s.rjust(5, "0") }
    supplier { nil }
  end
end
