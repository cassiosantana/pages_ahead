# frozen_string_literal: true

module Api
  class AccountsController < ApplicationController
    def index
      @accounts = Account.includes(:supplier).all
    end
  end
end
