# frozen_string_literal: true

module Api
  class AssembliesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create]
    before_action :set_assembly, only: %i[show]
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

    private

    def set_assembly
      @assembly = Assembly.find_by(id: params[:id])

      return if @assembly

      render json: { message: "Assembly not found." }, status: :not_found
    end

    def assembly_params
      params.require(:assembly).permit(:name)
    end
  end
end
