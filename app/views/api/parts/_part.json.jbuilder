json.id @part.id
json.name @part.name
json.number @part.part_number
json.price @part.price

json.supplier do
  json.id @part.supplier.id
  json.name @part.supplier.name
end
