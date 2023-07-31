# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Suppliers", type: :request do

  shared_examples_for "a successful response" do
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /api/suppliers" do
    let!(:suppliers) { create_list(:supplier, 5) }

    before do
      get "/api/suppliers"
    end

    include_examples "a successful response"

    it "returns a list of suppliers" do
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(5)
    end
  end
end
