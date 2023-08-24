json.id author.id
json.name author.name
json.cpf author.cpf
json.books author.books do |book|
  json.id book.id
  json.title book.title
end
