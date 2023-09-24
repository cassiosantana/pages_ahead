# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/assemblies/show", type: :view do
  let(:books) { create_list(:book, rand(1..10)) }
  let(:parts) { create_list(:part, rand(1..10)) }

  let(:assembly) { create(:assembly, books:, parts:) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  context "when show assemblies attributes and associations" do
    it "all data are displayed correctly" do
      expect(rendered).to have_text("Name: #{assembly.name}", normalize_ws: true)
      expect(rendered).to have_selector("p strong", text: "Parts:")
      assembly.parts.each do |part|
        expect(rendered).to have_text(part.name)
      end
      expect(rendered).to have_selector("p strong", text: "Books:")
      assembly.books.each do |book|
        expect(rendered).to have_text(book.title)
      end
    end
  end

  context "rendering links and button" do
    it "render the link to edit assembly" do
      expect(rendered).to have_link("Edit this assembly", href: edit_admin_assembly_path(assembly))
    end

    it "render the link to assemblies" do
      expect(rendered).to have_link("Back to assemblies", href: admin_assemblies_path)
    end

    it "render the button to destroy assembly" do
      expect(rendered).to have_button("Destroy this assembly")
    end
  end
end
