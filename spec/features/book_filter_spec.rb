# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Book filters", type: :feature do
  describe "Title filter" do
    let!(:book_one) { create(:book, title: "Book 1") }
    let!(:book_two) { create(:book, title: "Book 2") }
    let!(:book_three) { create(:book, title: "Book 3") }

    shared_examples "all books are visible" do
      it "shows all books" do
        expect(page).to have_content(book_one.title)
        expect(page).to have_content(book_two.title)
        expect(page).to have_content(book_three.title)
      end
    end

    before do
      visit admin_books_path
    end

    context "when initializing the page" do
      include_examples "all books are visible"
    end

    context "when filtering by title" do
      before do
        fill_in "q_title_or_author_name_cont", with: "Book 1"
        click_button "Search"
      end

      it "filters books correctly" do
        expect(page).to have_content(book_one.title)
        expect(page).to have_no_content(book_two.title)
        expect(page).to have_no_content(book_three.title)
      end

      context "when removing the title filter" do
        before do
          fill_in "q_title_or_author_name_cont", with: ""
          click_button "Search"
        end

        include_examples "all books are visible"
      end
    end

    context "when filtering by author name" do
      before do
        fill_in "q_title_or_author_name_cont", with: book_one.author.name
        click_button "Search"
      end

      it "filters books correctly" do
        expect(page).to have_content(book_one.title)
        expect(page).to have_no_content(book_two.title)
        expect(page).to have_no_content(book_three.title)
      end
    end
  end
end
