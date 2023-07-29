json.status :ok

json.author do
  json.id @author.id
  json.name params[:name]
end
