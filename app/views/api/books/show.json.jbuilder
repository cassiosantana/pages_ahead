json.id @book.id
json.published_at @book.published_at
json.author @book.author.name

json.assemblies @book.assemblies do |assembly|
  json.name assembly.name
end
