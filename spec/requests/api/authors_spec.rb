# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Authors", type: :request do

  shared_examples_for "a successful response" do
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /api/authors" do
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

  describe "GET /api/authors/:id" do
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

  describe "POST /api/authors" do
    context "when creating a new author with valid data" do
      let(:valid_author_params) do
        {
          author: {
            name: "New Author"
          }
        }
      end

      it "create author" do
        expect do
          post "/api/authors", params: valid_author_params
        end.to change(Author, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response["name"]).to eq("New Author")
      end
    end

    context "when creating a new author with invalid data" do
      let(:invalid_author_params) do
        {
          author: {
            name: ""
          }
        }
      end

      it "does not create author" do
        expect do
          post "/api/authors", params: invalid_author_params
        end.not_to change(Author, :count)
        expect(json_response["errors"]).to include("Name can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT /api/authors/:id" do
    context "with valid data" do
      let!(:author) { create(:author) }
      let(:valid_author_params) do
        {
          author: {
            name: "Updated author"
          }
        }
      end

      it "updates author" do
        patch "/api/authors/#{author.id}", params: valid_author_params

        expect(response).to have_http_status(:ok)

        author.reload
        expect(author.name).to eq("Updated author")
      end
    end

    context "with invalid data" do
      let!(:author) { create(:author) }
      let(:invalid_author_params) do
        {
          author: {
            name: ""
          }
        }
      end

      it "does not update the author" do
        expect do
          patch "/api/authors/#{author.id}", params: invalid_author_params
        end.not_to change(author, :name)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end

    context "when the author does not exist" do
      let(:invalid_author_params) do
        {
          author: {
            name: "Invalid Author"
          }
        }
      end
      it "returns an error message for non-existing author" do
        patch "/api/authors/-1", params: invalid_author_params

        expect(response).to have_http_status(:not_found)
        expect(json_response["message"]).to eq("Author not found.")
      end
    end
  end

  describe "DELETE /api/authors/:id" do
    context "when author exists" do
      let!(:author) { create(:author) }

      it "deletes the author" do
        expect do
          delete "/api/authors/#{author.id}"
        end.to change(Author, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect(json_response["message"]).to include("Author deleted successfully.")
      end
    end

    context "when author does not exist" do
      it "return an error message" do
        delete "/api/authors/-1"

        expect(response).to have_http_status(:not_found)
        expect(json_response["message"]).to include("Author not found")
      end
    end
  end
end
