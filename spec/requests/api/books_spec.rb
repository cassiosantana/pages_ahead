# frozen_string_literal: true

require "rails_helper"
require "isbn_generator"

RSpec.describe "Api::Books", type: :request do
  let(:assemblies) { create_list(:assembly, 3) }
  let(:author) { create(:author) }
  let(:book) { create(:book) }
  let(:valid_book_params) do
    {
      book: attributes_for(:book)
        .merge(
          author_id: author.id,
          assembly_ids: assemblies.map(&:id)
        )
    }
  end
  let(:invalid_book_params) do
    {
      book: {
        published_at: nil,
        isbn: nil,
        author_id: nil
      }
    }
  end

  shared_examples "all json errors" do
    it "receive all error messages" do
      expect(response).to have_http_status :unprocessable_entity
      expect(json_response["errors"]).to include(
        "Published at can't be blank",
        "Author must exist",
        "Isbn can't be blank",
        "Isbn is invalid"
      )
    end
  end

  describe "GET /api/books" do
    let!(:books) { create_list(:book, 5, author: author, assemblies: assemblies) }

    it "returns a successful response and correct books data" do
      get api_books_path

      expect(response).to have_http_status :ok
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(books.count)

      json_response.each do |book|
        book_record = Book.find(book["id"])
        expect(book["id"]).to eq(book_record.id)
        expect(book["published_at"].to_time).to eq(book_record.published_at.to_time)
        expect(book["isbn"]).to eq(book_record.isbn)
        expect(book["author"]["id"]).to eq(author.id)
        expect(book["author"]["name"]).to eq(author.name)
        expect(book["assemblies"].length).to eq(assemblies.count)

        book["assemblies"].each do |assembly|
          assembly_record = Assembly.find(assembly["id"])
          expect(assembly["id"]).to eq(assembly_record.id)
          expect(assembly["name"]).to eq(assembly_record.name)
        end
      end
    end
  end

  describe "GET /api/books/:id" do
    shared_examples "a book" do
      it "returns a successful response and correct book data" do
        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(book.id)
        expect(json_response["published_at"].to_time).to eq(book.published_at.to_time)
        expect(json_response["isbn"]).to eq(book.isbn)
        expect(json_response["author"]["id"]).to eq(book.author.id)
        expect(json_response["author"]["name"]).to eq(book.author.name)
      end
    end

    context "when book exist and have associated assemblies" do
      let!(:book) { create(:book, author: author, assemblies: assemblies) }

      before { get api_book_path(book) }

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
      before { get api_book_path(book) }

      it_behaves_like "a book"

      it "returns no assemblies" do
        expect(json_response["assemblies"]).to be_empty
      end
    end

    context "when book does not exist" do
      before { get api_book_path(-1) }

      it "returns a not found status and correct error message" do
        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Book not found.")
      end
    end
  end

  describe "POST /api/books" do
    context "when creating a new book with valid data" do
      subject { post api_books_path, params: valid_book_params }

      it "creates a new book and returns correct data" do
        expect { subject }.to change(Book, :count).by(1)

        subject
        expect(response).to have_http_status :created
        expect(json_response["id"]).to be_present
        expect(json_response["published_at"].to_date).to eq(valid_book_params[:book][:published_at].to_date)
        expect(json_response["isbn"]).to eq(valid_book_params[:book][:isbn])
        expect(json_response["author"]["id"]).to eq(author.id)
        expect(json_response["author"]["name"]).to eq(author.name)
        expect(json_response["assemblies"].length).to eq(assemblies.length)

        assembly_ids = assemblies.map(&:id)
        assembly_names = assemblies.map(&:name)
        json_response["assemblies"].each do |assembly|
          expect(assembly_ids).to include(assembly["id"])
          expect(assembly_names).to include(assembly["name"])
        end
      end
    end

    context "when trying to create a new book with invalid params" do
      before do
        post api_books_path, params: invalid_book_params
      end

      include_examples "all json errors"
    end
  end

  describe "PATCH /api/books/:id" do
    context "when the parameters are valid" do
      let!(:new_assemblies) { create_list(:assembly, 5) }
      let!(:new_author) { create(:author) }
      let!(:changes) do
        {
          book: attributes_for(:book)
            .merge(
              author_id: new_author.id,
              assembly_ids: book.assembly_ids.concat(new_assemblies.map(&:id))
            )
        }
      end

      it "updates the book and returns correct data" do
        patch api_book_path(book), params: changes

        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(book.id)
        expect(json_response["published_at"].to_date).to eq(changes[:book][:published_at].to_date)
        expect(json_response["isbn"]).to eq(changes[:book][:isbn])
        expect(json_response["author"]["id"]).to eq(new_author.id)
        expect(json_response["author"]["name"]).to eq(new_author.name)
        expect(json_response["assemblies"].length).to eq(Assembly.count)
      end
    end

    context "when trying to update with invalid params" do
      before do
        patch api_book_path(book), params: invalid_book_params
      end

      include_examples "all json errors"
    end
  end

  describe "DELETE /api/books/:id" do
    context "when trying to delete an existing book" do
      let!(:book) { create(:book) }

      it "returns correct status and delete the book" do
        delete api_book_path(book)

        expect(response).to have_http_status :no_content
      end
    end

    context "when trying to delete a non-existent book" do
      it "returns correct status and delete the book" do
        delete api_book_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Book not found.")
      end
    end

    context "when deleting book fails" do
      let!(:book) { create(:book) }

      it "we received the status and error message correctly" do
        allow_any_instance_of(Book).to receive(:destroy).and_return(false)

        delete api_book_path(book)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the book.")
      end
    end
  end
end
