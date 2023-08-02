json.array! @books do |book|
  json.id book.id
  json.published_at book.published_at
end
