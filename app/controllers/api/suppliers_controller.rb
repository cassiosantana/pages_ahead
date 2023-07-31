# frozen_string_literal: true

module Api
  class SuppliersController < ApplicationController

    def index
      @suppliers = Supplier.all
    end
  end
end
