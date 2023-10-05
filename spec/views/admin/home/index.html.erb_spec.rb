# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/home/index.html.erb", type: :view do
  describe "index" do
    it "renders the correct home content" do
      render

      expect(rendered).to have_selector("h1", text: "Welcome to Pages Ahead")
    end
  end
end
