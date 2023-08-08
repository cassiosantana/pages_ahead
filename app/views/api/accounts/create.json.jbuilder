json.id @account.id
json.number @account.account_number
json.supplier do
  json.id @account.supplier.id
  json.name @account.supplier.name
end
