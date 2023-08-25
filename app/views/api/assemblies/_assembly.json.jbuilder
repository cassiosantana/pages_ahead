json.id @assembly.id
json.name @assembly.name

json.books do
  json.array! @assembly.books do |book|
    json.id book.id
    json.title book.title
  end
end

json.parts do
  json.array! @assembly.parts do |part|
    json.id part.id
    json.name part.name
  end
end
