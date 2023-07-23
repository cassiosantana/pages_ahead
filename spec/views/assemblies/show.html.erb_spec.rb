# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/show", type: :view do
  let(:author) { create(:author) }
  let(:supplier) { create(:supplier) }
  let(:books) { create_list(:book, FFaker::Random.rand(0..10), author: author) }
  let(:parts) { create_list(:part, FFaker::Random.rand(0..10), supplier: supplier) }

  let(:assembly) { create(:assembly, books: books, parts: parts) }

  before(:each) do
    assign(:assembly, assembly)
    render
  end

  context "rendering of assemblies attributes" do
    it "render the assembly name" do
      expect(rendered).to have_text(assembly.name.to_s)
    end

    it "render the assembly's books" do
      expect(rendered).to have_selector("p strong", text: "Books:")
      assembly.books.each do |book|
        expect(rendered).to have_selector("ul li", text: book.published_at)
      end
    end

    it "render the assembly's parts" do
      expect(rendered).to have_selector("p strong", text: "Books:")
      assembly.parts.each do |part|
        expect(rendered).to have_selector("ul li", text: part.part_number)
      end
    end
  end

  context "rendering links and button" do
    it "render the link to edit assembly" do
      expect_link_to_edit(assembly)
    end

    it "render the link to assemblies" do
      expect_link_back_to("assemblies")
    end

    it "render the button to destroy assembly" do
      expect_submit_button("Destroy this assembly")
    end
  end
end
