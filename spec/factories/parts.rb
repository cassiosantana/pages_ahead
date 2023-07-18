# frozen_string_literal: true

FactoryBot.define do
  factory :part do
    part_number { FFaker::Random.rand(1..99_999).to_s.rjust(5, "0") }

    before(:create) do |part|
      part.supplier = create(:supplier)
    end
  end
end
