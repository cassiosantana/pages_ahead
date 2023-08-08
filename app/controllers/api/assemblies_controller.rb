# frozen_string_literal: true

module Api
  class AssembliesController < ApplicationController
    def index
      @assemblies = Assembly.all
    end
  end
end
