json.id book.id
json.title book.title
json.published_at book.published_at
json.isbn book.isbn

json.author do
  json.id book.author.id
  json.name book.author.name
end

json.assemblies do
  json.array! book.assemblies do |assembly|
    json.id assembly.id
    json.name assembly.name
  end
end
