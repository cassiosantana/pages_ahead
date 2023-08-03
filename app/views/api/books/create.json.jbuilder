json.id @book.id
json.published_at @book.published_at
json.author do
  json.id @book.author.id
  json.name @book.author.name
end

json.assemblies @book.assemblies do |assembly|
  json.id assembly.id
  json.name assembly.name
end
