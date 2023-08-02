# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    before_action :set_book, only: %i[show]

    def index
      @books = Book.all
    end

    def show; end

    private

    def set_book
      @book = Book.find_by(id: params[:id])

      return if @book

      render json: { message: "Book not found." }, status: :not_found
    end
  end
end
