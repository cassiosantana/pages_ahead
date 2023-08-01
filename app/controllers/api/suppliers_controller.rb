# frozen_string_literal: true

module Api
  class SuppliersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_supplier, only: %i[show update destroy]

    def index
      @suppliers = Supplier.all
    end

    def show; end

    def create
      @supplier = Supplier.new(supplier_params)

      if @supplier.save
        render :create, status: :created
      else
        render json: { errors: @supplier.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @supplier.update(supplier_params)
        render :update, status: :ok
      else
        render json: { errors: @supplier.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if @supplier.destroy
        render json: { message: "Supplier deleted successfully." }, status: :ok
      else
        render json: { errors: @supplier.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_supplier
      @supplier = Supplier.find_by(id: params[:id])

      return if @supplier

      render json: { message: "Supplier not found." }, status: :not_found
    end

    def supplier_params
      params.require(:supplier).permit(:name)
    end
  end
end