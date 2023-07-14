# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/index", type: :view do
  let(:assemblies) { create_list(:assembly, 5) }

  before(:each) do
    assign(:assemblies, assemblies)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Assemblies")
  end

  it "render a list of assemblies" do
    expect(rendered).to have_selector("#assemblies") do
      assemblies.each do |assembly|
        expect(rendered).to have_selector("p", text: "Assembly name: #{assembly.name} | Show this assembly")
      end
    end
  end
end
