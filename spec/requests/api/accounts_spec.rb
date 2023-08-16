# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Accounts", type: :request do
  describe "GET /api/accounts" do
    let!(:accounts) { create_list(:account, 3) }

    it "returns a list of accounts correctly" do
      get api_accounts_path

      expect(response).to have_http_status :ok
      expect(json_response.length).to eq(Account.all.count)
      json_response.each do |account|
        object = Account.find(account["id"])
        check_account_data(account, object)
      end
    end
  end

  describe "GET /api/accounts/:id" do
    context "when the account exists" do
      let!(:account) { create(:account) }

      it "show account data correctly" do
        get api_account_path(account)

        expect(response).to have_http_status :ok
        account = Account.find(json_response["id"])
        check_account_data(json_response, account)
      end
    end

    context "when the account does not exist" do
      it "show error message" do
        get api_account_path(-1)

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
        post api_accounts_path, params: valid_data

        expect(response).to have_http_status :created
        account = Account.find(json_response["id"])
        check_account_data(json_response, account)
        expect(Account.exists?(account_number: valid_data[:account][:account_number])).to eq(true)
      end
    end

    context "when trying to create an account with invalid data" do
      let!(:invalid_data) { { account: { account_number: "" } } }

      it "the account is not created successfully" do
        post api_accounts_path, params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"].length).to eq(2)
        expect(json_response["errors"]).to include("Account number can't be blank")
        expect(json_response["errors"]).to include("Supplier must exist")
      end
    end
  end

  describe "PATCH /api/accounts/:id" do
    let!(:account) { create(:account) }

    before do
      patch api_account_path(account), params: unauthorized_data
    end

    context "when attempting to change the account number" do
      let!(:unauthorized_data) { { account: { account_number: rand(10_000..99_999).to_s } } }

      it "respond with an unprocessable entity status and a error message" do
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Account number cannot be updated")
      end
    end

    context "when attempting to change the account supplier" do
      let!(:unauthorized_data) { { account: { supplier_id: -1 } } }

      it "respond with an unprocessable entity status and error messages" do
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Supplier cannot be updated")
        expect(json_response["errors"]).to include("Supplier must exist")
      end
    end
  end

  describe "DELETE /api/accounts/:id" do
    context "when trying to delete an account" do
      let!(:account) { create(:account) }

      it "the account will be deleted" do
        delete api_account_path(account)

        expect(response).to have_http_status :no_content
      end
    end

    context "when attempt to delete an non-existent account" do
      it "we received an error message" do
        delete api_account_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Account not found.")
      end
    end

    context "when deleting account fails" do
      let!(:account) { create(:account) }

      it "we received the status and error message correctly" do
        allow_any_instance_of(Account).to receive(:destroy).and_return(false)

        delete api_account_path(account)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the account.")
      end
    end
  end
end
