# frozen_string_literal: true

module Api
  class AssembliesController < ApplicationController
    before_action :set_assembly, only: %i[show]
    def index
      @assemblies = Assembly.all
    end

    def show; end

    private

    def set_assembly
      @assembly = Assembly.find_by(id: params[:id])

      return if @assembly

      render json: { message: "Assembly not found." }, status: :not_found
    end
  end
end
