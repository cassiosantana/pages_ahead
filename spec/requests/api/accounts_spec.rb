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
end
