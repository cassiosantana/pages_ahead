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
        expect(account["author"]["id"]).to be_present
        expect(account["author"]["name"]).to be_present
      end
    end
  end
end
