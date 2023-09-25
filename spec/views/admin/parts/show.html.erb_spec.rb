# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/parts/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:assemblies) { create_list(:assembly, 3) }
  let(:part) { create(:part, supplier:, assemblies:) }

  before(:each) do
    assign(:part, part)
    render
  end

  context "rendering of part attributes and associations" do
    it "all data is displayed correctly" do
      expect(rendered).to have_text("Name: #{part.name}", normalize_ws: true)
      expect(rendered).to have_text("Number: #{part.part_number}", normalize_ws: true)
      expect(rendered).to have_text("Supplier: #{part.supplier.name}", normalize_ws: true)
      expect(rendered).to have_selector("p strong", text: "Assemblies:")
      part.assemblies.each do |assembly|
        expect(rendered).to have_selector("ul li", text: assembly.name)
      end
    end
  end

  context "rendering links and button" do
    it "render the link to edit part" do
      expect(rendered).to have_link("Edit this part", href: edit_admin_part_path(part))
    end

    it "render the link to parts" do
      expect(rendered).to have_link("Back to parts", href: admin_parts_path)
    end

    it "render the button to destroy part" do
      expect(rendered).to have_button("Destroy this part")
    end
  end
end
