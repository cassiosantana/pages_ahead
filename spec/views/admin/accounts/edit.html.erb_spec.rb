# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/accounts/edit", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier:) }

  before(:each) do
    assign(:account, account)
    render
  end

  it "render the page title" do
    expect(rendered).to have_selector("h1", text: "Editing account")
  end

  context "editing the account" do
    it "not render the edit assembly form" do
      expect(rendered).to have_selector("form[action='#{admin_account_path(account)}'][method='post']") do
        expect(rendered).not_to have_selector("input[name='account[account_number]']")
        expect(rendered).not_to have_selector("select[name='account[supplier_id]']")
        expect(rendered).to have_button("Update Account")
      end
      expect(rendered).to have_selector("div", text: account.supplier.name)
      expect(rendered).to have_selector("div em", text: "It is not possible to change the supplier.")
      expect(rendered).to have_selector("div", text: account.number_with_digit)
      expect(rendered).to have_selector("div em", text: "It is not possible to change the account number.")
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

  context "rendering links" do
    it "renders the link to show account" do
      expect(rendered).to have_link("Show this account", href: admin_account_path(account))
    end

    it "renders the link to back to accounts" do
      expect(rendered).to have_link("Back to accounts", href: admin_accounts_path)
    end
  end
end
