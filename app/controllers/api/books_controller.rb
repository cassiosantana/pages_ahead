# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update destroy]
    before_action :set_book, only: %i[show update destroy]
    before_action :verify_assembly, only: %i[create update]

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

    def destroy
      if @book.destroy
        render json: { message: "Book deleted successfully" }, status: :ok
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

    def verify_assembly
      Api::AssemblyVerifier.call(book_params[:assembly_ids])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end
end
