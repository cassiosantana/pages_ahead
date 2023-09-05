# frozen_string_literal: true

require "rails_helper"

RSpec.describe "suppliers/edit", type: :view do
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier: supplier) }
  let(:account) { create(:account, supplier: supplier) }

  before(:each) do
    assign(:supplier, supplier)
    assign(:account, account)
    assign(:parts, parts)
    render
  end

  it "render the page title" do
    expect_page_title("Editing supplier")
  end

  it "render the supplier form" do
    form = "form[action='#{supplier_path(supplier)}'][method='post']"
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
    expect_submit_button("Update Supplier")
  end

  it "render the show supplier link" do
    expect_link_to_show(supplier)
  end

  it "render the back link" do
    expect_link_back_to("suppliers")
  end
end
