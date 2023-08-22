json.array! @suppliers do |supplier|
  json.id supplier.id
  json.name supplier.name
  json.cnpj supplier.cnpj
end
