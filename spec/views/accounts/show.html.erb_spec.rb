# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier: supplier) }

  before(:each) do
    assign(:account, account)
    render
  end

  context "account attribute rendering" do
    it "renders supplier and account number" do
      expect(rendered).to have_selector("p", text: "Supplier:\n    #{account.supplier.name}")
      expect(rendered).to have_selector("p", text: "Account number:\n    #{account.account_number}")
    end
  end

  context "link and button rendering" do
    it "render edit account link" do
      expect(rendered).to have_link("Edit this account", href: edit_account_path(account))
    end

    it "render back to accounts link" do
      expect(rendered).to have_link("Back to accounts", href: accounts_path)
    end

    it "render the button to destroy account" do
      expect(rendered).to have_button("Destroy this account")
    end
  end
end
