# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Books", type: :request do
  describe "GET /api/books" do
    let!(:assemblies) { create_list(:assembly, 3) }
    let!(:author) { create(:author) }
    let!(:books) { create_list(:book, 5, author: author, assemblies: assemblies) }

    before do
      get "/api/books"
    end

    it "returns a successful response and correct books data" do
      expect(response).to have_http_status :ok
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(books.count)

      json_response.each do |book|
        expect(book["id"]).to be_present
        expect(book["published_at"]).to be_present
        expect(book["author"]["id"]).to eq(author.id)
        expect(book["author"]["name"]).to eq(author.name)
        expect(book["assemblies"].length).to eq(assemblies.count)

        book["assemblies"].each do |assembly|
          expect(assembly["id"]).to be_present
          expect(assembly["name"]).to be_present
        end
      end
    end
  end

  describe "GET /api/books/:id" do
    shared_examples "a book" do
      it "returns a successful response and correct book data" do
        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(book.id)
        expect(json_response["published_at"].to_time).to eq(book.published_at)
        expect(json_response["author"]["id"]).to eq(author.id)
        expect(json_response["author"]["name"]).to eq(author.name)
      end
    end

    context "when book exist and have associated assemblies" do
      let!(:assemblies) { create_list(:assembly, 3) }
      let!(:author) { create(:author) }
      let!(:book) { create(:book, author: author, assemblies: assemblies) }

      before { get "/api/books/#{book.id}" }

      it_behaves_like "a book"

      it "returns the correct number and data of assemblies" do
        expect(json_response["assemblies"].length).to eq(3)

        assembly_ids = assemblies.map(&:id)
        assembly_names = assemblies.map(&:name)
        json_response["assemblies"].each do |assembly|
          expect(assembly_ids).to include(assembly["id"])
          expect(assembly_names).to include(assembly["name"])
        end
      end
    end

    context "when the book exists but has no associated assemblies" do
      let!(:author) { create(:author) }
      let!(:book) { create(:book, author: author) }

      before { get "/api/books/#{book.id}" }

      it_behaves_like "a book"

      it "returns no assemblies" do
        expect(json_response["assemblies"]).to be_empty
      end
    end

    context "when book does not exist" do
      before { get "/api/books/-1" }

      it "returns a not found status and correct error message" do
        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Book not found.")
      end
    end
  end

  describe "POST /api/books" do
    context "when creating a new book with valid data" do
      let!(:assemblies) { create_list(:assembly, 3) }
      let!(:author) { create(:author) }
      let!(:valid_book_params) do
        {
          book: {
            published_at: Time.current,
            author_id: author.id,
            assembly_ids: assemblies.map(&:id)
          }
        }
      end

      subject { post "/api/books", params: valid_book_params }

      it "creates a new book and returns correct data" do
        expect { subject }.to change(Book, :count).by(1)

        subject
        expect(response).to have_http_status :created
        expect(json_response["id"]).to be_present
        expect(json_response["published_at"].to_date).to eq(valid_book_params[:book][:published_at].to_date)
        expect(json_response["author"]["id"]).to eq(author.id)
        expect(json_response["author"]["name"]).to eq(author.name)
        expect(json_response["assemblies"].length).to eq(assemblies.count)

        assembly_ids = assemblies.map(&:id)
        assembly_names = assemblies.map(&:name)
        json_response["assemblies"].each do |assembly|
          expect(assembly_ids).to include(assembly["id"])
          expect(assembly_names).to include(assembly["name"])
        end
      end
    end

    context "when creating a new book with invalid data" do
      let!(:invalid_book_params) do
        {
          book: {
            published_at: nil,
            author_id: nil,
            assembly_ids: nil
          }
        }
      end

      subject { post "/api/books", params: invalid_book_params }

      it "does not create a new book and returns correct error messages" do
        expect { subject }.not_to change(Book, :count)

        subject
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Published at can't be blank")
        expect(json_response["errors"]).to include("Author must exist")
      end
    end
  end

  describe "PATCH /api/books/:id" do
    let!(:assemblies) { create_list(:assembly, 3) }
    let!(:new_assemblies) { create_list(:assembly, 5) }
    let!(:new_author) { create(:author) }

    context "when the parameters are valid" do
      let!(:book) { create(:book, assemblies: assemblies) }

      let!(:valid_book_params) do
        {
          book: {
            published_at: Time.current,
            assembly_ids: book.assembly_ids.concat(new_assemblies.map(&:id)),
            author_id: new_author.id
          }
        }
      end

      before do
        patch "/api/books/#{book.id}", params: valid_book_params
      end

      it "updates the book and returns correct data" do
        expect(response).to have_http_status :ok
        expect(Time.iso8601(json_response["published_at"]).change(usec: 0))
          .to eq(valid_book_params[:book][:published_at].change(usec: 0))
        expect(json_response["assemblies"].length).to eq(8)
        expect(json_response["author"]["id"]).to eq(new_author.id)
        expect(json_response["author"]["name"]).to eq(new_author.name)
      end
    end

    context "when the parameters are invalid" do
      let!(:book) { create(:book) }

      let!(:invalid_book_params) do
        {
          book: {
            published_at: nil,
            author_id: nil
          }
        }
      end

      before do
        patch "/api/books/#{book.id}", params: invalid_book_params
      end

      it "does not update the book and returns correct error messages" do
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Author must exist")
        expect(json_response["errors"]).to include("Published at can't be blank")
      end
    end
  end

  describe "DELETE /api/books/:id" do
    context "when trying to delete an existing book" do
      let!(:book) { create(:book) }

      it "returns correct status and delete the book" do
        delete "/api/books/#{book.id}"

        expect(response).to have_http_status :ok
        expect(json_response["message"]).to eq("Book deleted successfully")
      end
    end

    context "when trying to delete a non-existent book" do
      it "returns correct status and delete the book" do
        delete "/api/books/-1"

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Book not found.")
      end
    end
  end
end