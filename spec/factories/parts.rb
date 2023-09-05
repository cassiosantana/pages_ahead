# frozen_string_literal: true

FactoryBot.define do
  factory :part do
    name { FFaker::Product.product_name }
    part_number { rand(10_000..99_999).to_s }
    supplier { create(:supplier) }
  end
end
