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
5.times do
  Author.create(name: FFaker::Name.name, cpf: FFaker::IdentificationBR.cpf)
end

# Supplier
21.times do
  Supplier.create(name: FFaker::Company.name, cnpj: FFaker::IdentificationBR.cnpj)
end

# Account
suppliers_ids = Supplier.pluck(:id)

suppliers_ids.each do |supplier_id|
  account_number = rand(10_000..99_999).to_s
  Account.create(account_number:, supplier_id:)
end

# Parts (Changed to make unique parts for each supplier)
part_names = ["Hard Cover", "Soft Cover", "Premium Cover", "Dust Jacket", "Comic Book Cover",
              "Standard Size Page", "Large Print Page", "Deckle Edge",
              "Glossy Page", "Acid-free Page", "Premium Paper Page",
              "Recycled Paper Page", "Gilded Edge", "Endpapers",
              "Header", "Footer", "Bookmark", "Binding", "Corner Cut",
              "Fold", "Creases"]

_parts = part_names.each_with_index.map do |name, index|
  part_number = rand(10_000..99_999)
  Part.create(name:, part_number:, price: rand(14.9..49.9).round(2),
              supplier_id: suppliers_ids[index % suppliers_ids.size])
end

# Assemblies (Made adjustments to more closely mirror real-world book assemblies)
assembly_specifications = {
  "paperback" => ["Soft Cover", "Standard Size Page", "Acid-free Page"],
  "hardcover" => ["Hard Cover", "Dust Jacket", "Acid-free Page"],
  "deluxe edition" => ["Premium Cover", "Glossy Page", "Endpapers"],
  "collector's edition" => ["Hard Cover", "Gilded Edge", "Endpapers"],
  "limited edition" => ["Premium Cover", "Deckle Edge", "Gilded Edge"]
}

_assemblies = assembly_specifications.map do |name, specs|
  assembly_parts = specs.map { |spec| Part.find_by(name: spec) }.compact
  assembly = Assembly.create(name:)
  assembly.parts << assembly_parts
  assembly
end

# Books
5.times do
  random_author = Author.order("RANDOM()").first
  random_assembly = Assembly.order("RANDOM()").first
  book = Book.create(title: FFaker::Book.title, published_at: FFaker::Time.between(DateTime.now - 1.year, DateTime.now),
                     author: random_author, isbn: IsbnGenerator.isbn_thirteen)
  book.assemblies << random_assembly
end
