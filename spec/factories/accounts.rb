# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    supplier { create(:supplier) }
    account_number { rand(10_000..99_999) }
    check_digit { rand(0..9) }
  end
end
