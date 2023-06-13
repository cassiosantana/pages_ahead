# frozen_string_literal: true

FactoryBot.define do
  factory :assembly do
    name { FFaker::Lorem.word }
  end
end
