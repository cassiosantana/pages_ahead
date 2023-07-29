# frozen_string_literal: true

module Api
  class AuthorsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update]
    before_action :set_author, only: %i[show update]

    def index
      @authors = Author.all

      respond_to do |format|
        format.json
      end
    end

    def show; end

    def create
      @author = Author.new(author_params)

      if @author.save
        render json: @author, status: :created
      else
        render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @author.update(author_params)
        render json: @author, status: :ok
      else
        render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name)
    end
  end
end
