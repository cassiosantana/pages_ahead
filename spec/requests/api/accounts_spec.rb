# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Accounts", type: :request do
  describe "GET /api/accounts" do
    let!(:accounts) { create_list(:account, 3) }

    it "returns a list of accounts correctly" do
      get "/api/accounts"

      expect(response).to have_http_status :ok
      expect(json_response.length).to eq(Account.all.count)
      json_response.each do |account|
        expect(account["id"]).to be_present
        expect(account["number"]).to be_present
        expect(account["supplier"]["id"]).to be_present
        expect(account["supplier"]["name"]).to be_present
      end
    end
  end

  describe "GET /api/accounts/:id" do
    context "when the account exists" do
      let!(:account) { create(:account) }

      it "show account data correctly" do
        get "/api/accounts/#{account.id}"

        expect(response).to have_http_status :ok
        expect(json_response["id"]).to be_present
        expect(json_response["number"]).to be_present
        expect(json_response["supplier"]["id"]).to be_present
        expect(json_response["supplier"]["name"]).to be_present
      end
    end

    context "when the account does not exist" do
      it "show error message" do
        get "/api/accounts/-1"

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Account not found.")
      end
    end
  end

  describe "POST /api/accounts" do
    context "when trying to create an account with valid data" do
      let!(:supplier) { create(:supplier) }
      let!(:valid_data) { { account: { account_number: "{#{rand(10_000..99_999)}}", supplier_id: supplier.id } } }

      it "the account is successfully created" do
        post "/api/accounts", params: valid_data

        expect(response).to have_http_status :created
        expect(json_response["id"]).to be_present
        expect(json_response["number"]).to be_present
        expect(Account.exists?(account_number: valid_data[:account][:account_number])).to eq(true)
        expect(json_response["supplier"]["id"]).to eq(supplier.id)
        expect(json_response["supplier"]["name"]).to eq(supplier.name)
      end
    end

    context "when trying to create an account with invalid data" do
      let!(:invalid_data) { { account: { account_number: "" } } }

      it "the account is not created successfully" do
        post "/api/accounts", params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"].length).to eq(2)
        expect(json_response["errors"]).to include("Account number can't be blank")
        expect(json_response["errors"]).to include("Supplier must exist")
      end
    end
  end
end
