# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]

  def index
    @accounts = Account.all
  end

  def show; end

  def new
    @account = Account.new
  end

  def edit; end

  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to account_url(@account), notice: "Account was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @account.update(account_params)
      redirect_to account_url(@account), notice: "Account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account.destroy

    redirect_to accounts_url, notice: "Account was successfully destroyed."
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:supplier_id, :account_number)
  end
end
