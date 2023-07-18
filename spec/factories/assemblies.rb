# frozen_string_literal: true

FactoryBot.define do
  factory :assembly do
    name { FFaker::Lorem.word }

    before(:create) do |assembly|
      author = create(:author)
      supplier = create(:supplier)
      assembly.books = create_list(:book, 5, author: author)
      assembly.parts = create_list(:part, 3, supplier: supplier)
    end
  end
end

