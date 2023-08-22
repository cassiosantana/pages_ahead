# frozen_string_literal: true

module AssemblyServices
  class ExistenceVerifierService < ApplicationService
    def initialize(ids)
      super
      @ids = ids
    end

    def call
      return if @ids.nil? || Assembly.where(id: @ids).pluck(:id) == @ids&.map(&:to_i)

      raise ActiveRecord::RecordNotFound, "One or more assemblies not found."
    end
  end
end
