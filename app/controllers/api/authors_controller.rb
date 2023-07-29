# frozen_string_literal: true

module Api
  class AuthorsController < ApplicationController
    before_action :set_author, only: :show

    def index
      @authors = Author.all

      respond_to do |format|
        format.json
      end
    end

    def show; end

    private

    def set_author
      @author = Author.find(params[:id])
    end
  end
end
