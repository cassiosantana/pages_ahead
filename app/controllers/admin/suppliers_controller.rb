# frozen_string_literal: true

module Admin
  class SuppliersController < ApplicationController
    before_action :set_supplier, only: %i[show edit update destroy]

    def index
      @q = Supplier.ransack(params[:q])
      @suppliers = @q.result(distinct: true).includes(parts: { assemblies: { books: :author } })
    end

    def show; end

    def new
      @supplier = Supplier.new
    end

    def edit; end

    def create
      @supplier = Supplier.new(supplier_params)

      if @supplier.save
        redirect_to admin_supplier_url(@supplier), notice: "Supplier was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @supplier.update(supplier_params)
        redirect_to admin_supplier_url(@supplier), notice: "Supplier was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @supplier.destroy

      redirect_to admin_suppliers_url, notice: "Supplier was successfully destroyed."
    end

    def report
      @supplier = Supplier.find_with_associations(params[:id])
      @authors  = @supplier.associated_authors
      @books = @supplier.associated_books
    end

    private

    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    def supplier_params
      params.require(:supplier).permit(:name, :cnpj)
    end
  end
end
