# frozen_string_literal: true

module Api
  class SuppliersController < Api::ApiController
    before_action :set_supplier, only: %i[show update destroy]

    def index
      @suppliers = Supplier.all
    end

    def show; end

    def create
      @supplier = Supplier.new(supplier_params)

      return render :create, status: :created if @supplier.save

      render json: { errors: @supplier.errors.full_messages }, status: :unprocessable_entity
    end

    def update
      return render :update, status: :ok if @supplier.update(supplier_params)

      render json: { errors: @supplier.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
      return head :no_content if @supplier.destroy

      render json: { message: "Failed to delete the supplier." }, status: :unprocessable_entity
    end

    private

    def set_supplier
      @supplier = Supplier.find_by(id: params[:id])

      render json: { message: "Supplier not found." }, status: :not_found unless @supplier
    end

    def supplier_params
      params.require(:supplier).permit(:name, :cnpj)
    end
  end
end
