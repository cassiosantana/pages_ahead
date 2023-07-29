# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Authors", type: :request do

  shared_examples_for "a successful response" do
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /index" do
    let!(:authors) { create_list(:author, 3) }

    before do
      get "/api/authors"
    end

    include_examples "a successful response"

    it "returns a list of authors" do
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(authors.count)
    end
  end

  describe "GET /show" do
    context "when author exist" do
      let!(:author) { create(:author) }

      before do
        get "/api/authors/#{author.id}"
      end

      include_examples "a successful response"

      it "returns the details of a specific author" do
        expect(json_response["id"]).to eq(author.id)
        expect(json_response["name"]).to eq(author.name)
      end
    end

    context "when the author does not exist" do
      it "returns an error message for non-existing author" do
        get "/api/authors/-1"

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Author not found.")
      end
    end
  end
end
