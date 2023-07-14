# frozen_string_literal: true

require "rails_helper"

RSpec.describe "accounts/edit", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier: supplier) }

  before(:each) do
    assign(:account, account)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Editing account")
  end

  context "account attribute rendering" do
    it "render account number" do
      expect(rendered).to have_selector("div", text: "Account number:\n        #{account.account_number}")
    end

    it "render supplier name" do
      expect(rendered).to have_selector("div", text: "Supplier:\n        #{account.supplier.name}")
    end
  end

  context "message that it is not possible to edit the attribute" do
    it "render account number message" do
      expect(rendered).to have_selector("em", text: "It is not possible to change the account number.")
    end

    it "render supplier message" do
      expect(rendered).to have_selector("em", text: "It is not possible to change the supplier.")
    end
  end

  context "rendering links and button" do
    it "renders the link to show account" do
      expect(rendered).to have_link("Show this account", href: account_path(account))
    end

    it "renders the link to back to accounts" do
      expect(rendered).to have_link("Back to accounts", href: accounts_path)
    end

    it "renders the button to update account" do
      expect(rendered).to have_button("Update Account")
    end
  end
end
