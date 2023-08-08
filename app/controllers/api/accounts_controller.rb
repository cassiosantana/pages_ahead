# frozen_string_literal: true

module Api
  class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update]
    before_action :set_account, only: %i[show update]
    def index
      @accounts = Account.includes(:supplier).all
    end

    def show; end

    def create
      @account = Account.new(account_params)

      if @account.save
        render :create, status: :created
      else
        render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if account_params.key?(:account_number) || account_params.key?(:supplier_id)
        render json: { message: "Update of account_number or supplier_id is not allowed." },
               status: :unprocessable_entity
      elsif @account.update(account_params)
        render :update, status: :ok
      else
        render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_account
      @account = Account.find_by(id: params[:id])

      return if @account

      render json: { message: "Account not found." }, status: :not_found
    end

    def account_params
      params.require(:account).permit(:account_number, :supplier_id)
    end
  end
end
