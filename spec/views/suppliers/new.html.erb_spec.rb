# frozen_string_literal: true

require "rails_helper"

RSpec.describe "suppliers/new", type: :view do
  let(:supplier) { build(:supplier) }

  before(:each) do
    assign(:supplier, supplier)
    render
  end

  it "render the page title" do
    expect_page_title("New supplier")
  end

  it "render the supplier form" do
    expect(rendered).to have_selector("form[action='#{suppliers_path}'][method='post']") do
      expect(rendered).to have_selector("input[type='text'][name='supplier[name]']")
      expect_submit_button("Create Supplier")
    end
  end

  it "render the back link" do
    expect_link_back_to("suppliers")
  end
end
