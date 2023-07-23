# frozen_string_literal: true

require "rails_helper"

RSpec.describe "suppliers/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:parts) { create_list(:part, 3, supplier: supplier) }
  let(:account) { create(:account, supplier: supplier) }
  let(:supplier_without_associations) { create(:supplier) }

  it "render supplier name" do
    assign(:supplier, supplier)
    render

    expect(rendered).to have_text(supplier.name)
  end


  context "when the supplier has no associations" do
    before(:each) do
      assign(:supplier, supplier_without_associations)
      render
    end

    it "the supplier does not have an account" do
      expect(rendered).to have_selector("p strong", text: "Account:")
      expect(supplier.account).to be_nil
    end

    it "the parts list is empty" do
      expect(supplier.parts).to be_empty
    end
  end

  context "when the supplier has associations" do
    before(:each) do
      assign(:supplier, supplier)
      assign(:account, account)
      assign(:parts, parts)

      render
    end

    it "render supplier account" do
      expect(rendered).to have_text(supplier.account.account_number)
    end

    it "render supplier parts" do
      expect(supplier.parts.count).to be(3)
      expect(supplier.parts.count).to be(Part.where(supplier: supplier).count)
      supplier.parts.each do |part|
        expect(rendered).to have_selector("ul li", text: part.part_number)
      end
    end
  end

  context "rendering links and button" do
    before(:each) do
      assign(:supplier, supplier)
      render
    end

    it "render the link to edit supplier" do
      expect_link_to_edit(supplier)
    end

    it "render the link to all suppliers" do
      expect_link_back_to("suppliers")
    end

    it "render the button to destroy supplier" do
      expect_submit_button("Destroy this supplier")
    end
  end

  context "when the supplier has no associations" do
    before(:each) do
      assign(:supplier, supplier_without_associations)
      render
    end

    it "the supplier does not have an account" do
      expect(rendered).to have_selector("p strong", text: "Account:")
      expect(supplier.account).to be_nil
    end

    it "the parts list is empty" do
      expect(supplier.parts).to be_empty
    end
  end

  context "when the supplier has associations" do
    before(:each) do
      assign(:supplier, supplier)
      assign(:account, account)
      assign(:parts, parts)

      render
    end

    it "render supplier account" do
      expect(rendered).to have_text(supplier.account.account_number)
    end

    it "render supplier parts" do
      expect(supplier.parts.count).to be(3)
      expect(supplier.parts.count).to be(Part.where(supplier: supplier).count)
      supplier.parts.each do |part|
        expect(rendered).to have_selector("ul li", text: part.part_number)
      end
    end
  end

  context "rendering links and button" do
    before(:each) do
      assign(:supplier, supplier)
      render
    end

    it "render the link to edit supplier" do
      expect_link_to_edit(supplier)
    end

    it "render the link to all suppliers" do
      expect_link_back_to("suppliers")
    end

    it "render the button to destroy supplier" do
      expect_submit_button("Destroy this supplier")
    end
  end
end
