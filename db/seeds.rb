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
5.times do
  Supplier.create(name: FFaker::Company.name, cnpj: FFaker::IdentificationBR.cnpj)
end

# Account
suppliers_ids = Supplier.pluck(:id)

suppliers_ids.each do |supplier_id|
  account_number = rand(10_000..99_999).to_s
  Account.create(account_number: account_number, supplier_id: supplier_id)
end

# Parts
part_names = ["Hard Cover", "Soft Cover", "Premium Cover", "Dust Jacket", "Comic Book Cover",
              "Standard Size Page", "Large Print Page", "Deckle Edge",
              "Glossy Page", "Acid-free Page", "Premium Paper Page",
              "Recycled Paper Page", "Gilded Edge", "Endpapers",
              "Header", "Footer", "Bookmark", "Binding", "Corner Cut",
              "Fold", "Creases"]

parts = part_names.map do |name|
  Part.create(name: name, part_number: rand(10_000..99_999), supplier_id: Supplier.pluck(:id).sample)
end

# Assemblies
assembly_names = ["paperback", "hardcover", "deluxe edition", "collector's edition", "limited edition"]

assemblies = assembly_names.map do |name|
  Assembly.create(name: name)
end

parts.each do |part|
  part.assemblies << assemblies.sample(rand(1..5))
end

# Books
5.times do
  random_author_id = Author.pluck(:id).sample
  book = Book.create(title: FFaker::Book.title, published_at: FFaker::Time.between(DateTime.now - 1.year, DateTime.now),
                     author_id: random_author_id, isbn: IsbnGenerator.isbn_thirteen)
  book.assemblies << assemblies.sample(rand(1..5))
end
