# frozen_string_literal: true

require "rails_helper"

RSpec.describe "parts/edit", type: :view do
  let(:not_associated_assemblies) { create_list(:assembly, 3) }
  let(:associated_assemblies) { create_list(:assembly, 4) }
  let(:part) { create(:part, supplier: create(:supplier), assemblies: associated_assemblies) }

  before(:each) do
    assign(:part, part)
    assign(:not_associated_assemblies, not_associated_assemblies)
    render
  end

  it "render the page title" do
    expect_page_title("Editing part")
  end

  it "render the part form" do
    form = "form[action='#{part_path(part)}'][method='post']"
    name = "input[name='part[name]'][value='#{part.name}']"
    number = "input[name='part[part_number]'][value='#{part.part_number}']"
    assembly_ids = "input[type='checkbox'][name='part[assembly_ids][]']"

    expect(rendered).to have_selector(form)
    expect(rendered).to have_selector(name)
    expect(rendered).to have_selector(number)
    expect(rendered).to have_selector(assembly_ids, count: Assembly.count)
    Assembly.all.each do |assembly|
      if part.assemblies.include?(assembly)
        assemblies_checked = "input[type='checkbox'][name='part[assembly_ids][]'][value='#{assembly.id}'][checked]"
        expect(rendered).to have_selector(assemblies_checked)
      else
        assemblies_not_checked = "input[type='checkbox'][name='part[assembly_ids][]'][value='#{assembly.id}']:not([checked])"
        expect(rendered).to have_selector(assemblies_not_checked)
      end
    end
    expect_submit_button("Update Part")
  end

  it "render the show part link" do
    expect_link_to_show(part)
  end

  it "render the back link" do
    expect_link_back_to("parts")
  end
end
