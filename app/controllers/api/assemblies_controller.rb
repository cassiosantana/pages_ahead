# frozen_string_literal: true

module Api
  class AssembliesController < Api::ApiController
    before_action :set_assembly, only: %i[show update destroy]
    def index
      @assemblies = Assembly.all
    end

    def show; end

    def create
      @assembly = Assembly.new(assembly_params)

      return render :create, status: :created if @assembly.save

      render json: { errors: @assembly.errors.full_messages }, status: :unprocessable_entity
    end

    def update
      return render :update, status: :ok if @assembly.update(assembly_params)

      render json: { errors: @assembly.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
      return head :no_content if @assembly.destroy

      render json: { message: "Failed to delete the assembly." }, status: :unprocessable_entity
    end

    private

    def set_assembly
      @assembly = Assembly.find_by(id: params[:id])

      render json: { message: "Assembly not found." }, status: :not_found unless @assembly
    end

    def assembly_params
      params.require(:assembly).permit(:name, book_ids: [], part_ids: [])
    end
  end
end
