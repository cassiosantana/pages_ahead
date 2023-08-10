# frozen_string_literal: true

module Api
  class PartsController < Api::ApiController
    before_action :set_part, only: %i[show]
    def index
      @parts = Part.all
    end

    def show; end

    def create
      @part = Part.new(part_params)

      if @part.save
        render :create, status: :created
      else
        render json: { errors: @part.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_part
      @part = Part.find_by(id: params[:id])

      return if @part

      render json: { message: "Part not found." }, status: :not_found
    end

    def part_params
      params.require(:part).permit(:part_number, :supplier_id)
    end
  end
end
