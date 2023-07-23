# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'ffaker'

Author.destroy_all
Supplier.destroy_all
Account.destroy_all
Part.destroy_all
Assembly.destroy_all
Book.destroy_all
ActiveRecord::Base.connection.execute("DELETE FROM assemblies_books")
ActiveRecord::Base.connection.execute("DELETE FROM assemblies_parts")

5.times do
  Author.create(name: FFaker::Name.name)
end

5.times do
  Supplier.create(name: FFaker::Name.name)
end

suppliers_ids = Supplier.pluck(:id)

suppliers_ids.each do |supplier_id|
  account_number = "#{FFaker::Random.rand(1..99_999).to_s.rjust(5, '0')}-#{FFaker::Random.rand(1..9)}"
  Account.create(account_number: account_number, supplier_id: supplier_id)
end

parts = 20.times.map do
  Part.create(part_number: FFaker::Random.rand(1..99_999).to_s.rjust(5, '0'),
              supplier_id: Supplier.pluck(:id).sample)
end

assemblies = ["paperback", "hardcover", "deluxe edition", "collector's edition", "limited edition"].map do |name|
  Assembly.create(name: name)
end

parts.each do |part|
  part.assemblies << assemblies.sample(rand(1..5))
end

5.times do
  random_author_id = Author.pluck(:id).sample
  book = Book.create(published_at: FFaker::Time.between(DateTime.now - 1.year, DateTime.now), author_id: random_author_id)
  book.assemblies << assemblies.sample(rand(1..5))
end


