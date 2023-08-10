# frozen_string_literal: true

module Api
  class PartsController < Api::ApiController
    def index
      @parts = Part.all
    end
  end
end
