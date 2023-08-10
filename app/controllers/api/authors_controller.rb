# frozen_string_literal: true

module Api
  class AuthorsController < Api::ApiController
    before_action :set_author, only: %i[show update destroy]

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
        head :no_content
      else
        render json: { message: "Failed to delete the author." }, status: :unprocessable_entity
      end
    end

    private

    def set_author
      @author = Author.find_by(id: params[:id])

      return if @author

      render json: { message: "Author not found." }, status: :not_found
    end

    def author_params
      params.require(:author).permit(:name)
    end
  end
end
