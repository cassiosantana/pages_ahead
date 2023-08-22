# frozen_string_literal: true

module Api
  class PartsController < Api::ApiController
    before_action :set_part, only: %i[show update destroy]
    before_action :verify_assembly, only: %i[create update]

    def index
      @parts = Part.all
    end

    def show; end

    def create
      @part = Part.new(part_params)

      return render :create, status: :created if @part.save

      render json: { errors: @part.errors.full_messages }, status: :unprocessable_entity
    end

    def update
      return render :update, status: :ok if @part.update(part_params)

      render json: { errors: @part.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
      return head(:no_content) if @part.destroy

      render json: { message: "Failed to delete the part." }, status: :unprocessable_entity
    end

    private

    def set_part
      @part = Part.find_by(id: params[:id])

      render json: { message: "Part not found." }, status: :not_found unless @part
    end

    def part_params
      params.require(:part).permit(:part_number, :supplier_id, assembly_ids: [])
    end

    def verify_assembly
      AssemblyServices::ExistenceVerifierService.call(part_params[:assembly_ids]) if part_params[:assembly_ids].present?
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end
end
