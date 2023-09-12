# frozen_string_literal: true

require "ffaker"
require "isbn_generator"

Author.destroy_all
Supplier.destroy_all
Account.destroy_all
Part.destroy_all
Assembly.destroy_all
Book.destroy_all
ActiveRecord::Base.connection.execute("DELETE FROM assemblies_books")
ActiveRecord::Base.connection.execute("DELETE FROM assemblies_parts")

# Author
authors = []
5.times do
  authors << Author.create(name: FFaker::Name.name, cpf: FFaker::IdentificationBR.cpf)
end

# Supplier
5.times do
  Supplier.create(name: FFaker::Company.name, cnpj: FFaker::IdentificationBR.cnpj)
end

# Account
suppliers_ids = Supplier.pluck(:id)

suppliers_ids.each do |supplier_id|
  Account.create(account_number: rand(10_000..99_999).to_s, supplier_id:)
end

# Parts
part_names = ["Hard Cover", "Soft Cover", "Premium Cover", "Dust Jacket", "Comic Book Cover",
              "Standard Size Page", "Large Print Page", "Deckle Edge",
              "Glossy Page", "Premium Paper Page",
              "Recycled Paper Page", "Gilded Edge", "Endpapers",
              "Header", "Footer", "Bookmark", "Binding", "Corner Cut",
              "Fold", "Creases"]

part_names.each_slice(4).with_index do |name_slice, index|
  name_slice.each do |name|
    Part.create(name:, part_number: rand(10_000..99_999), price: rand(14.9..49.9).round(2),
                supplier_id: suppliers_ids[index])
  end
end

# Assemblies
assembly_specifications = {
  "paperback" => ["Soft Cover", "Standard Size Page", "Acid-free Page", "Comic Book Cover", "Bookmark"],
  "hardcover" => ["Hard Cover", "Dust Jacket", "Acid-free Page", "Large Print Page", "Header"],
  "deluxe edition" => ["Premium Cover", "Glossy Page", "Endpapers", "Premium Paper Page", "Footer"],
  "collector's edition" => ["Hard Cover", "Gilded Edge", "Endpapers", "Recycled Paper Page", "Binding"],
  "limited edition" => ["Premium Cover", "Deckle Edge", "Gilded Edge", "Creases", "Corner Cut", "Fold"]
}

assembly_specifications.each do |name, specs|
  assembly_parts = specs.map { |spec| Part.find_by(name: spec) }.compact
  assembly = Assembly.create(name:)
  assembly.parts << assembly_parts
end

# Books
assemblies = Assembly.all.to_a.shuffle
remaining_assemblies = assemblies.clone

authors.each do |author|
  first_assembly = remaining_assemblies.pop
  second_assembly = (remaining_assemblies - [first_assembly]).sample

  # restart with all assemblies when we've run through all once
  remaining_assemblies = assemblies.clone if remaining_assemblies.empty?

  book = Book.create(title: FFaker::Book.title,
                     published_at: FFaker::Time.between(DateTime.now - 1.year, DateTime.now),
                     author:,
                     isbn: IsbnGenerator.isbn_thirteen)

  book.assemblies << first_assembly
  book.assemblies << second_assembly unless second_assembly.nil?
end
