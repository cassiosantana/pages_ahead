# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Authors", type: :request do
  describe "GET /index" do
    let!(:authors) { create_list(:author, 3) }

    before do
      get "/api/authors"
    end

    it "returns a success response" do
      expect(response).to have_http_status(:ok)
    end

    it "returns a list of authors" do
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(authors.count)
    end
  end
end
