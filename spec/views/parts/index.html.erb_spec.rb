# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/parts/index", type: :view do
  let(:parts) { create_list(:part, 3) }

  before(:each) do
    assign(:parts, parts)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Parts")
  end

  it "render a list of parts" do
    parts.each do |part|
      expect(rendered).to have_text("Name: #{part.name}", normalize_ws: true)
      expect(rendered).to have_link("Show this part", href: admin_part_path(part))
    end
  end

  it "render a link to new assembly" do
    expect(rendered).to have_link("New part", href: new_admin_part_path)
  end
end
