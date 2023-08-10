# frozen_string_literal: true

module Api
  class AssembliesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update destroy]
    before_action :set_assembly, only: %i[show update destroy]
    def index
      @assemblies = Assembly.all
    end

    def show; end

    def create
      @assembly = Assembly.new(assembly_params)

      if @assembly.save
        render :create, status: :created
      else
        render json: { errors: @assembly.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @assembly.update(assembly_params)
        render :update, status: :ok
      else
        render json: { errors: @assembly.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if @assembly.destroy
        head :no_content
      else
        render json: { message: "Failed to delete the assembly." }, status: :unprocessable_entity
      end
    end

    private

    def set_assembly
      @assembly = Assembly.find_by(id: params[:id])

      return if @assembly

      render json: { message: "Assembly not found." }, status: :not_found
    end

    def assembly_params
      params.require(:assembly).permit(:name, book_ids: [], part_ids: [])
    end
  end
end
