# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    name { FFaker::Name.name }
    cnpj { FFaker::IdentificationBR.cnpj }
  end
end
