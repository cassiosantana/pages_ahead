# frozen_string_literal: true

class AssembliesController < ApplicationController
  before_action :set_assembly, only: %i[show edit update destroy]

  def index
    @assemblies = Assembly.all
  end

  def show; end

  def new
    @assembly = Assembly.new
  end

  def edit; end

  def create
    @assembly = Assembly.new(assembly_params)

    if @assembly.save
      redirect_to assembly_url(@assembly), notice: "Assembly was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @assembly.update(assembly_params)

      %i[part book].each do |attribute|
        @assembly.send(attribute.to_s.pluralize).clear

        attribute_ids = Array(params[:assembly][:"#{attribute}_ids"]).select(&:present?)
        @assembly.send("#{attribute}_ids=", attribute_ids)
      end

      redirect_to assembly_url(@assembly), notice: "Assembly was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @assembly.destroy

    redirect_to assemblies_url, notice: "Assembly was successfully destroyed."
  end

  private

  def set_assembly
    @assembly = Assembly.find(params[:id])
  end

  def assembly_params
    params.require(:assembly).permit(:name, part_ids: [], book_ids: [])
  end
end
