# frozen_string_literal: true

module Api
  class AccountsController < ApplicationController
    before_action :set_account, only: %i[show]
    def index
      @accounts = Account.includes(:supplier).all
    end

    def show; end

    private

    def set_account
      @account = Account.find_by(id: params[:id])

      return if @account

      render json: { message: "Account not found." }, status: :not_found
    end
  end
end
