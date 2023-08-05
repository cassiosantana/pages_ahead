module Api
  class AssemblyVerifier < Api::BaseService
    attr_reader :ids

    def initialize(ids)
      super
      @ids = ids
    end

    def call
      return if Assembly.where(id: ids).pluck(:id) == ids.to_a

      raise ActiveRecord::RecordNotFound, "One or more assemblies not found."
    end
  end
end
