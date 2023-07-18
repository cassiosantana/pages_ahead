# frozen_string_literal: true

require "rails_helper"

RSpec.describe "parts/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:assemblies) { create_list(:assembly, 3) }
  let(:part) { create(:part, supplier: supplier, assemblies: assemblies) }

  before(:each) do
    assign(:part, part)
    render
  end

  context "rendering of part attributes" do
    it "render the part number" do
      expect(rendered).to have_text(part.part_number.to_s)
    end

    it "render the supplier name" do
      expect(rendered).to have_text(part.supplier.name.to_s)
    end

    it "render the part's assemblies" do
      expect(rendered).to have_selector("p strong", text: "Assemblies:")
      part.assemblies.each do |assembly|
        expect(rendered).to have_selector("ul li", text: assembly.name)
      end
    end
  end

  context "rendering links and button" do
    it "render the link to edit part" do
      expect_link_to_edit(part)
    end

    it "render the link to part" do
      expect_link_back_to("parts")
    end

    it "render the button to destroy part" do
      expect_submit_button("Destroy this part")
    end
  end
end
