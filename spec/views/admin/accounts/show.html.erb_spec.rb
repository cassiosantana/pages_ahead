# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/accounts/show", type: :view do
  let(:supplier) { create(:supplier) }
  let(:account) { create(:account, supplier:) }

  before(:each) do
    assign(:account, account)
    render
  end

  context "account attribute rendering" do
    it "renders supplier and account number" do
      expect(rendered).to have_text("Supplier: #{account.supplier.name}", normalize_ws: true)
      expect(rendered).to have_text("Account number: #{account.number_with_digit}", normalize_ws: true)
    end
  end

  context "link and button rendering" do
    it "render edit account link" do
      expect(rendered).to have_link("Edit this account", href: edit_admin_account_path(account))
    end

    it "render back to accounts link" do
      expect(rendered).to have_link("Back to accounts", href: admin_accounts_path)
    end

    it "render the button to destroy account" do
      expect(rendered).to have_button("Destroy this account")
    end
  end
end
