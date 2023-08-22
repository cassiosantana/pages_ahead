module RequestSpecHelper
  def json_response
    JSON.parse(response.body)
  end

  def check_account_data(json_data, object)
    expect(json_data["id"]).to eq(object.id)
    expect(json_data["number"]).to eq(object.number_with_digit)
    expect(json_data["supplier"]["id"]).to eq(object.supplier.id)
    expect(json_data["supplier"]["name"]).to eq(object.supplier.name)
  end
end
