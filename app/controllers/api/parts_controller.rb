# frozen_string_literal: true

module Api
  class PartsController < Api::ApiController
    before_action :set_part, only: %i[show]
    def index
      @parts = Part.all
    end

    def show; end

    private

    def set_part
      @part = Part.find_by(id: params[:id])

      return if @part

      render json: { message: "Part not found." }, status: :not_found
    end
  end
end
