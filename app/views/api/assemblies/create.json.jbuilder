json.id @assembly.id
json.name @assembly.name

json.books do
  json.array! @assembly.books do |book|
    json.id book.id
    json.published_at book.published_at
  end
end

json.parts do
  json.array! @assembly.parts do |part|
    json.id part.id
    json.number part.part_number
  end
end
