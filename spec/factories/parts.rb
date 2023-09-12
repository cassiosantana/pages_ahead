# frozen_string_literal: true

FactoryBot.define do
  factory :part do
    name { FFaker::Product.product_name }
    part_number { rand(10_000..99_999).to_s }
    price { rand(14.9..49.9).round(2) }
    supplier { create(:supplier) }
  end
end
