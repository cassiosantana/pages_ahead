# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Assembly filters", type: :feature do
  describe "Part name filter" do
    let!(:part) { create(:part) }
    let!(:assembly_one) { create(:assembly, name: "Assembly 1", parts: [part]) }
    let!(:assembly_two) { create(:assembly, name: "Assembly 2") }
    let!(:assembly_three) { create(:assembly, name: "Assembly 3") }

    shared_examples "all assemblies are visible" do
      it "shows all assemblies" do
        expect(page).to have_content(assembly_one.name)
        expect(page).to have_content(assembly_two.name)
        expect(page).to have_content(assembly_three.name)
      end
    end

    before do
      visit admin_assemblies_path
    end

    context "when initializing the page" do
      include_examples "all assemblies are visible"
    end

    context "when filtering by part name" do
      before do
        fill_in "q_parts_name_cont", with: part.name
        click_button "Search"
      end

      it "filters assemblies correctly" do
        expect(page).to have_content(assembly_one.name)
        expect(page).to have_no_content(assembly_two.name)
        expect(page).to have_no_content(assembly_three.name)
      end

      context "when removing the part name filter" do
        before do
          fill_in "q_parts_name_cont", with: ""
          click_button "Search"
        end

        include_examples "all assemblies are visible"
      end
    end
  end
end
