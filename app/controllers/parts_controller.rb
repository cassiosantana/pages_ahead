# frozen_string_literal: true

class PartsController < ApplicationController
  before_action :set_part, only: %i[show edit update destroy]

  def index
    @parts = Part.all
  end

  def show; end

  def new
    @part = Part.new
  end

  def edit; end

  def create
    @part = Part.new(part_params)

    if @part.save
      redirect_to part_url(@part), notice: "Part was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @part.update(part_params)
      @part.assemblies.clear

      assembly_ids = Array(params[:part][:assembly_ids]).select(&:present?)
      @part.assembly_ids = assembly_ids

      redirect_to part_url(@part), notice: "Part was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @part.destroy

    redirect_to parts_url, notice: "Part was successfully destroyed."
  end

  private

  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    params.require(:part).permit(:name, :part_number, :price, :supplier_id, assembly_ids: [])
  end
end
