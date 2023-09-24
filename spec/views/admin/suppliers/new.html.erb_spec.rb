# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/suppliers/new", type: :view do
  let(:supplier) { build(:supplier) }

  before(:each) do
    assign(:supplier, supplier)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "New supplier")
  end

  it "render the supplier form" do
    form = "form[action='#{admin_suppliers_path}'][method='post']"
    name = "input[type='text'][name='supplier[name]'][value=\"#{supplier.name}\"]"
    cnpj = "input[type='text'][name='supplier[cnpj]'][value=\"#{supplier.cnpj}\"]"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(name)
    expect(rendered).to have_selector(cnpj)
    expect(rendered).to have_button("Create Supplier")
  end

  it "render the back link" do
    expect(rendered).to have_link("Back to suppliers", href: admin_suppliers_path)
  end
end
