# frozen_string_literal: true

module Api
  class AuthorsController < ApplicationController
    def index
      @authors = Author.all

      respond_to do |format|
        format.json
      end
    end
  end
end
