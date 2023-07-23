# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    supplier { nil }
    account_number { "#{FFaker::Random.rand(10_000..90_999)}-#{FFaker::Random.rand(0..9)}" }
  end
end
