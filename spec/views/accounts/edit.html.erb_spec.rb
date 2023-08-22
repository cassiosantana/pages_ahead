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
    expect_page_title("Editing account")
  end

  context "editing the account" do
    it "not render the edit assembly form" do
      expect(rendered).to have_selector("form[action='#{account_path(account)}'][method='post']") do
        expect(rendered).not_to have_selector("input[name='account[account_number]']")
        expect(rendered).not_to have_selector("select[name='account[supplier_id]']")
        expect_submit_button("Update Account")
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
      expect_link_to_show(account)
    end

    it "renders the link to back to accounts" do
      expect_link_back_to("accounts")
    end
  end
end
