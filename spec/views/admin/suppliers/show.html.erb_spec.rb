# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/suppliers/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier:) }
  let(:account) { create(:account, supplier:) }
  let(:supplier_without_associations) { create(:supplier) }

  context "when the supplier has associations" do
    it "renders the supplier correctly" do
      assign(:supplier, supplier)
      assign(:parts, parts)
      assign(:account, account)
      render

      expect(rendered).to have_text("Name: #{supplier.name}", normalize_ws: true)
      expect(rendered).to have_text("Cnpj: #{supplier.cnpj}", normalize_ws: true)
      expect(rendered).to have_text("Account: #{supplier.account_with_digit}", normalize_ws: true)
      supplier.parts.each do |part|
        expect(rendered).to have_selector("ul li", text: part.name)
      end
    end
  end

  context "when the supplier has no associations" do
    it "renders the supplier correctly" do
      assign(:supplier, supplier_without_associations)
      render

      expect(rendered).to have_text("Name: #{supplier_without_associations.name}", normalize_ws: true)
      expect(rendered).to have_text("Cnpj: #{supplier_without_associations.cnpj}", normalize_ws: true)
      expect(rendered).to have_text("Account: ", normalize_ws: true)
      expect(rendered).to have_selector("ul#test-parts_list", text: "")
    end
  end

  context "when rendering the page the links and button" do
    before(:each) do
      assign(:supplier, supplier)
      render
    end

    it "they are displayed correctly" do
      expect(rendered).to have_link("Edit this supplier", href: edit_admin_supplier_path(supplier))
      expect(rendered).to have_link("Back to suppliers", href: admin_suppliers_path)
      expect(rendered).to have_button("Destroy this supplier")
    end
  end
end
