# frozen_string_literal: true

module Api
  class BooksController < Api::ApiController
    before_action :set_book, only: %i[show update destroy]
    before_action :verify_assembly, only: %i[create update]

    def index
      @books = Book.includes(:author, :assemblies).all
    end

    def show; end

    def create
      @book = Book.new(book_params)

      return render :create, status: :created if @book.save

      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end

    def update
      return render :update, status: :ok if @book.update(book_params)

      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
      return head :no_content if @book.destroy

      render json: { message: "Failed to delete the book." }, status: :unprocessable_entity
    end

    private

    def set_book
      @book = Book.find_by(id: params[:id])

      render json: { message: "Book not found." }, status: :not_found unless @book
    end

    def book_params
      params.require(:book).permit(:title, :published_at, :isbn, :author_id, assembly_ids: [])
    end

    def verify_assembly
      AssemblyServices::ExistenceVerifierService.call(book_params[:assembly_ids]) if book_params[:assembly_ids].present?
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end
end
