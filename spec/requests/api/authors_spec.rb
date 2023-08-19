# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Authors", type: :request do
  let(:valid_author_params) do
    {
      author: {
        name: FFaker::Name.name,
        cpf: FFaker::IdentificationBR.cpf
      }
    }
  end

  let(:invalid_author_params) { { author: { name: "" } } }

  describe "GET /api/authors" do
    let!(:authors) { create_list(:author, 3) }

    it "returns a successful response and correct books data" do
      get api_authors_path

      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(authors.count)

      json_response.each do |author|
        author_record = Author.find(author["id"])
        expect(author["id"]).to eq(author_record.id)
        expect(author["name"]).to eq(author_record.name)
        expect(author["cpf"]).to eq(author_record.cpf)
        expect(author["books"]).to be_an(Array)
      end
    end
  end

  describe "GET /api/authors/:id" do
    context "when author exist and have associated books" do
      let!(:author) { create(:author) }
      let!(:books) { create_list(:book, 3, author: author) }

      it "returns the details of a specific author" do
        get api_author_path(author)

        expect(json_response["id"]).to eq(author.id)
        expect(json_response["name"]).to eq(author.name)
        expect(json_response["cpf"]).to eq(author.cpf)

        book_ids = books.map(&:id)
        book_published_ats = books.map(&:published_at)
        json_response["books"].each do |book|
          expect(book_ids).to include(book["id"])
          expect(book_published_ats).to include(book["published_at"])
        end
      end
    end

    context "when the author does not exist" do
      it "returns an error message for non-existing author" do
        get api_author_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Author not found.")
      end
    end
  end

  describe "POST /api/authors" do
    context "when creating a new author with valid data" do
      it "creates a new author and returns correct data" do
        expect do
          post api_authors_path, params: valid_author_params
        end.to change(Author, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response["id"]).to be_present
        expect(json_response["name"]).to eq(valid_author_params[:author][:name])
        expect(json_response["cpf"]).to eq(valid_author_params[:author][:cpf])
        expect(json_response["books"]).to be_an(Array)
        expect(json_response["books"]).to be_empty
      end
    end

    context "when creating a new author with invalid data" do
      it "does not create author" do
        expect do
          post api_authors_path, params: invalid_author_params
        end.not_to change(Author, :count)
        expect(json_response["errors"]).to include("Name can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT /api/authors/:id" do
    context "with valid data" do
      let!(:author) { create(:author) }

      it "updates author" do
        patch api_author_path(author), params: valid_author_params

        expect(response).to have_http_status(:ok)

        expect(json_response["id"]).to eq(author.id)
        expect(json_response["name"]).to eq(valid_author_params[:author][:name])
        expect(json_response["cpf"]).to eq(valid_author_params[:author][:cpf])
        expect(json_response["books"]).to be_an(Array)
        expect(json_response["books"]).to be_empty
      end
    end

    context "with invalid data" do
      let!(:author) { create(:author) }

      it "does not update the author" do
        expect do
          patch api_author_path(author), params: invalid_author_params
        end.not_to change(author, :name)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end

    context "when the author does not exist" do
      it "returns an error message for non-existing author" do
        patch api_author_path(-1)

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
          delete api_author_path(author)
        end.to change(Author, :count).by(-1)

        expect(response).to have_http_status :no_content
      end
    end

    context "when author does not exist" do
      it "return an error message" do
        delete api_author_path(-1)

        expect(response).to have_http_status(:not_found)
        expect(json_response["message"]).to include("Author not found.")
      end
    end

    context "when deleting author fails" do
      let!(:author) { create(:author) }

      it "we received the status and error message correctly" do
        allow_any_instance_of(Author).to receive(:destroy).and_return(false)

        delete api_author_path(author)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the author.")
      end
    end
  end
end
