# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update]
    before_action :set_book, only: %i[show update]

    def index
      @books = Book.includes(:author, :assemblies).all
    end

    def show; end

    def create
      @book = Book.new(book_params)

      if @book.save
        render :create, status: :created
      else
        render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        render :update, status: :ok
      else
        render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_book
      @book = Book.find_by(id: params[:id])

      return if @book

      render json: { message: "Book not found." }, status: :not_found
    end

    def book_params
      params.require(:book).permit(:published_at, :author_id, assembly_ids: [])
    end
  end
end
