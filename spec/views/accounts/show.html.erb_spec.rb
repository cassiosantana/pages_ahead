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
      expect_link_to_edit(account)
    end

    it "render back to accounts link" do
      expect_link_back_to("accounts")
    end

    it "render the button to destroy account" do
      expect_submit_button("Destroy this account")
    end
  end
end
