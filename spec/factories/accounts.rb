# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    supplier { nil }
    account_number { "MyString" }
  end
end
