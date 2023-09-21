# frozen_string_literal: true

module Admin
  class BooksController < ApplicationController
    before_action :set_book, only: %i[show edit update destroy]

    def index
      @q = Book.ransack(params[:q])
      @books = @q.result(distinct: true).includes(:author)
    end

    def show; end

    def new
      @book = Book.new
    end

    def edit; end

    def create
      @book = Book.new(book_params)

      if @book.save
        redirect_to admin_book_url(@book), notice: "Book was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        @book.assemblies.clear

        assembly_ids = Array(params[:book][:assembly_ids]).select(&:present?)
        @book.assembly_ids = assembly_ids

        redirect_to admin_book_url(@book), notice: "Book was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy

      redirect_to admin_books_url, notice: "Book was successfully destroyed."
    end

    def report
      @book = Book.includes(assemblies: :parts).find(params[:id])
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :published_at, :isbn, :author_id, assembly_ids: [])
    end
  end
end
