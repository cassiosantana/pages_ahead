# frozen_string_literal: true

module Api
  class BooksController < ApplicationController

    def index
      @books = Book.all
    end
  end
end
