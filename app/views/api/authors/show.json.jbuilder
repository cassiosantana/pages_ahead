json.id @author.id
json.name @author.name
json.books @author.books do |book|
  json.id book.id
  json.published_at book.published_at
end
