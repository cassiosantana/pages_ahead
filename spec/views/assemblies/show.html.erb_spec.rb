# frozen_string_literal: true

require "rails_helper"

RSpec.describe "assemblies/show", type: :view do
  let(:assembly) { create(:assembly) }
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
  end
end
