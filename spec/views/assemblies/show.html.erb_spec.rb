# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/show", type: :view do
  let(:assembly) { create(:assembly) }
  before(:each) do
    assign(:assembly, assembly)
    render
  end

  context "rendering of assemblies attributes" do
    it "render the assembly name" do
      expect(rendered).to have_text(assembly.name.to_s)
    end
  end
end
