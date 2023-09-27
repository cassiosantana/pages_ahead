# frozen_string_literal: true

require "rails_helper"

RSpec.describe Assemblies::ExistenceVerifier do
  let(:assemblies) { create_list(:assembly, 3) }

  context "when assemblies exists for provided id" do
    it "returns nil" do
      verifier = Assemblies::ExistenceVerifier.new(assemblies.map(&:id))
      expect(verifier.call).to eq(nil)
    end
  end

  context "when assemblies do not exist for provided ids" do
    it "raises an ActiveRecord::RecordNotFound error" do
      verifier = Assemblies::ExistenceVerifier.new([10_000, 20_000])
      expect { verifier.call }.to raise_error(ActiveRecord::RecordNotFound, "One or more assemblies not found.")
    end
  end
end
