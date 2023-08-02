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

  describe "GET /api/books/:id" do
    context "when book exist" do
      let!(:author) { create(:author) }
      let!(:book) { create(:book, author: author) }

      it "returns a book" do
        get "/api/books/#{book.id}"

        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(book.id)
        expect(json_response["published_at"].to_time).to eq(book.published_at)
      end
    end

    context "when book does not exist" do
      it "return a error message" do
        get "/api/books/-1"

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Book not found.")
      end
    end
  end
end
