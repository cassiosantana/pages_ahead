# frozen_string_literal: true

module Api
  class AuthorsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update destroy]
    before_action :set_author, only: %i[show update destroy]
    before_action :books_exist?, only: %i[create update]

    def index
      @authors = Author.includes(:books).all
    end

    def show; end

    def create
      @author = Author.new(author_params)

      if @author.save
        render :create, status: :created
      else
        render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @author.update(author_params)
        render :update, status: :ok
      else
        render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if @author.destroy
        render json: { message: "Author deleted successfully." }, status: :ok
      else
        render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_author
      @author = Author.find_by(id: params[:id])

      return if @author

      render json: { message: "Author not found." }, status: :not_found
    end

    def author_params
      params.require(:author).permit(:name, book_ids: [])
    end

    def books_exist?
      return if Book.where(id: author_params[:book_ids]).pluck(:id) == author_params[:book_ids].to_a

      render json: { message: "Book not found." }, status: :not_found
    end
  end
end
