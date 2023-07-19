# frozen_string_literal: true

require "rails_helper"

RSpec.describe "parts/new", type: :view do
  let(:part) { build(:part) }
  before(:each) do
    assign(:part, part)
    assign(:suppliers, [
             Supplier.create(name: "Supplier 1"),
             Supplier.create(name: "Supplier 2")
           ])
    assign(:assemblies, create_list(:assembly, FFaker::Random.rand(0..10)))

    render
  end

  it "render the page title" do
    expect_page_title("New part")
  end

  it "render the part form" do
    expect(rendered).to have_selector("form[action='#{parts_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='part[part_number]']")
      expect(rendered).to have_selector("select[name='part[supplier_id]']")
      expect(rendered).to have_select("part_supplier_id", with_options: ["Supplier 1", "Supplier 2"])
      expect(rendered).to have_selector("input[type='checkbox'][name='part[assembly_ids][]']", count: Assembly.count)
      expect_submit_button("Create Part")
    end
  end

  it "render the back link" do
    expect_link_back_to("parts")
  end
end
