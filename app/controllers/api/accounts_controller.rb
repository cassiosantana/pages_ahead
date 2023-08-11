# frozen_string_literal: true

module Api
  class AccountsController < Api::ApiController
    before_action :set_account, only: %i[show update destroy]

    def index
      @accounts = Account.includes(:supplier).all
    end

    def show; end

    def create
      @account = Account.new(account_params)

      return render :create, status: :created if @account.save

      render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
    end

    def update
      return render :update, status: :ok if @account.update(account_params)

      render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
      return head :no_content if @account.destroy

      render json: { message: "Failed to delete the account." }, status: :unprocessable_entity
    end

    private

    def set_account
      @account = Account.find_by(id: params[:id])

      render json: { message: "Account not found." }, status: :not_found unless @account
    end

    def account_params
      params.require(:account).permit(:account_number, :supplier_id)
    end
  end
end
