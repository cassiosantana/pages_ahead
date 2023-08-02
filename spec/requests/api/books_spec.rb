# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Books", type: :request do
  describe "GET /api/books" do
    let!(:author) { create(:author) }
    let!(:books) { create_list(:book, 5, author: author) }

    it "returns a list of books" do
      get "/api/books"

      expect(response).to have_http_status :ok
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(5)
    end
  end
end
