# frozen_string_literal: true

module Api
  class SuppliersController < ApplicationController
    before_action :set_supplier, only: %i[show]

    def index
      @suppliers = Supplier.all
    end

    def show; end

    def set_supplier
      @supplier = Supplier.find_by(id: params[:id])

      return if @supplier

      render json: { message: "Supplier not found" }, status: :not_found
    end
  end
end
