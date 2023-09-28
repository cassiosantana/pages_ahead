# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/parts/new", type: :view do
  let(:part) { build(:part) }
  let(:supplier1) { create(:supplier, name: "Supplier 1") }
  let(:supplier2) { create(:supplier, name: "Supplier 2") }
  let(:assemblies) { create_list(:assembly, rand(11)) }

  before(:each) do
    assign(:part, part)
    assign(:suppliers, [supplier1, supplier2])
    assign(:assemblies, assemblies)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "New part")
  end

  it "render the part form" do
    form = "form[action='#{admin_parts_path}'][method='post']"
    number = "input[name='part[part_number]']"
    supplier = "select[name='part[supplier_id]']"
    select = "part_supplier_id"
    check_boxes = "input[type='checkbox'][name='part[assembly_ids][]']"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(number)
    expect(rendered).to have_selector(supplier)
    expect(rendered).to have_select(select, with_options: ["Supplier 1", "Supplier 2"])
    expect(rendered).to have_selector(check_boxes, count: Assembly.count)
    expect(rendered).to have_button("Create Part")
  end

  it "render the back link" do
    expect(rendered).to have_link("Back to parts", href: admin_parts_path)
  end
end
