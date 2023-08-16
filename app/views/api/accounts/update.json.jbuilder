json.id @account.id
json.number @account.number_with_digit
json.supplier do
  json.id @account.supplier.id
  json.name @account.supplier.name
end
