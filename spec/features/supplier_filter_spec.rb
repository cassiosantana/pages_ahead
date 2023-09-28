# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Supplier filters", type: :feature do
  describe "Name filter" do
    let!(:supplier_one) { create(:supplier, name: "Supplier 1") }
    let!(:part) { create(:part, supplier: supplier_one) }
    let!(:assembly) { create(:assembly, parts: [part]) }
    let!(:book) { create(:book, assemblies: [assembly]) }

    let!(:supplier_two) { create(:supplier, name: "Supplier 2") }
    let!(:supplier_three) { create(:supplier, name: "Supplier 3") }
    let!(:account) { create(:account) }

    shared_examples "all suppliers are visible" do
      it "shows all suppliers" do
        expect(page).to have_content(supplier_one.name)
        expect(page).to have_content(supplier_two.name)
        expect(page).to have_content(supplier_three.name)
      end
    end

    before do
      visit admin_suppliers_path
    end

    context "when initializing the page" do
      include_examples "all suppliers are visible"
    end

    context "when filtering by name" do
      before do
        fill_in "q_name_or_account_account_number_or_parts_assemblies_books_author_name_cont", with: "Supplier 1"
        click_button "Search"
      end

      it "filters suppliers correctly" do
        expect(page).to have_content(supplier_one.name)
        expect(page).to have_no_content(supplier_two.name)
        expect(page).to have_no_content(supplier_three.name)
      end

      context "when removing parameter filter" do
        before do
          fill_in "q_name_or_account_account_number_or_parts_assemblies_books_author_name_cont", with: ""
          click_button "Search"
        end

        include_examples "all suppliers are visible"
      end
    end

    context "when filtering by account number" do
      before do
        fill_in "q_name_or_account_account_number_or_parts_assemblies_books_author_name_cont",
                with: account.account_number
        click_button "Search"
      end

      it "filters suppliers correctly" do
        expect(page).to have_content(account.supplier.name)
        expect(page).to have_no_content(supplier_one.name)
        expect(page).to have_no_content(supplier_two.name)
        expect(page).to have_no_content(supplier_three.name)
      end
    end

    context "when filtering by author name" do
      before do
        fill_in "q_name_or_account_account_number_or_parts_assemblies_books_author_name_cont",
                with: book.author.name
        click_button "Search"
      end

      it "filters suppliers correctly" do
        expect(page).to have_content(supplier_one.name)
        expect(page).to have_no_content(supplier_two.name)
        expect(page).to have_no_content(supplier_three.name)
      end
    end
  end
end
