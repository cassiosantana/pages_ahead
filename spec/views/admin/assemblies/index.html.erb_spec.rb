# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/assemblies/index", type: :view do
  let(:assemblies) { create_list(:assembly, 5) }

  before(:each) do
    assign(:assemblies, assemblies)
    assign(:q, Assembly.ransack)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Assemblies")
  end

  it "render a list of assemblies" do
    assemblies.each do |assembly|
      expect(rendered).to have_text("Name: #{assembly.name}", normalize_ws: true)
      expect(rendered).to have_link("Show this assembly", href: admin_assembly_path(assembly))
    end
  end

  it "render a link to new assembly" do
    expect(rendered).to have_link("New assembly", href: new_admin_assembly_path)
  end
end
