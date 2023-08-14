# frozen_string_literal: true

require "rails_helper"

RSpec.describe "suppliers/edit", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier: supplier) }

  before(:each) do
    assign(:supplier, supplier)
    assign(:account, account)
    render
  end

  it "render the page title" do
    expect_page_title("Editing supplier")
  end

  it "render the supplier form" do
    expect(rendered).to have_selector("form[action='#{supplier_path(supplier)}'][method='post']") do
      expect(rendered).to have_selector("input[type='text'][name='supplier[name]'][value=\"#{supplier.name}\"]")
      expect(rendered).to have_selector("input[type='text'][name='supplier[cnpj]'][value=\"#{supplier.cnpj}\"]")
      expect_submit_button("Update Supplier")
    end
  end

  it "render the show supplier link" do
    expect_link_to_show(supplier)
  end

  it "render the back link" do
    expect_link_back_to("suppliers")
  end
end
