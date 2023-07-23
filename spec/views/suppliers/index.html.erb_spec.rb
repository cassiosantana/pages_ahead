# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "suppliers/index", type: :view do
  let(:suppliers) { create_list(:supplier, 3) }

  before(:each) do
    assign(:suppliers, suppliers)
    render
  end

  it "render the page title" do
    expect_page_title("Suppliers")
  end

  it "render a list of suppliers" do
    expect_object_list(suppliers)
  end

  it "render a link to new supplier" do
    expect_link_to_new("supplier")
  end
end
