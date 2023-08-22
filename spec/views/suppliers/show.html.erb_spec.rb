# frozen_string_literal: true

require "rails_helper"

RSpec.describe "suppliers/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier: supplier) }
  let(:account) { create(:account, supplier: supplier) }
  let(:supplier_without_associations) { create(:supplier) }

  context "when the supplier has associations" do
    it "renders the supplier correctly" do
      assign(:supplier, supplier)
      render

      expect(rendered).to have_selector("p", text: supplier.name)
      expect(rendered).to have_selector("p", text: supplier.cnpj)
      expect(rendered).to have_selector("div", text: supplier.account_with_digit)
      supplier.parts.each do |part|
        expect(rendered).to have_selector("ul li", text: part.part_number)
      end
    end
  end

  context "when the supplier has no associations" do
    it "renders the supplier correctly" do
      assign(:supplier, supplier_without_associations)
      render

      expect(rendered).to have_selector("p", text: supplier_without_associations.name)
      expect(rendered).to have_selector("p", text: supplier_without_associations.cnpj)
      expect(rendered).to have_selector("span#test-account_with_digit_value", text: "")
      expect(rendered).to have_selector("ul#test-parts_list", text: "")
    end
  end

  context "when rendering the page the links and button" do
    before(:each) do
      assign(:supplier, supplier)
      render
    end

    it "they are displayed correctly" do
      expect_link_to_edit(supplier)
      expect_link_back_to("suppliers")
      expect_submit_button("Destroy this supplier")
    end
  end
end
