# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/suppliers/edit", type: :view do
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier:) }
  let(:account) { create(:account, supplier:) }

  before(:each) do
    assign(:supplier, supplier)
    assign(:account, account)
    assign(:parts, parts)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Editing supplier")
  end

  it "render the supplier form" do
    form = "form[action='#{admin_supplier_path(supplier)}'][method='post']"
    name = "input[type='text'][name='supplier[name]'][value=\"#{supplier.name}\"]"
    cnpj = "input[type='text'][name='supplier[cnpj]'][value=\"#{supplier.cnpj}\"]"
    account = "Account: #{supplier.account_with_digit}"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(name)
    expect(rendered).to have_selector(cnpj)
    expect(rendered).to have_text(account, normalize_ws: true)
    expect(rendered).to have_selector("em", text: "It is not possible to change the account.")
    expect(rendered).to have_selector("strong", text: "Parts:")
    expect(rendered).to have_selector("em", text: "It is not possible to change the parts.")
    supplier.parts.each do |part|
      expect(rendered).to have_selector("ul li", text: part.name)
    end
    expect(rendered).to have_button("Update Supplier")
  end

  it "render the show supplier link" do
    expect(rendered).to have_link("Show this supplier", href: admin_supplier_path(supplier))
  end

  it "render the back link" do
    expect(rendered).to have_link("Back to suppliers", href: admin_suppliers_path)
  end
end
