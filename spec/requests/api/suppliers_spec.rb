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

  describe "GET /api/suppliers/:id" do
    context "when supplier exist" do
      let!(:supplier) { create(:supplier) }

      before do
        get "/api/suppliers/#{supplier.id}"
      end

      include_examples "a successful response"

      it "returns a supplier" do
        expect(json_response["id"]).to eq(supplier.id)
        expect(json_response["name"]).to eq(supplier.name)
      end
    end

    context "when supplier does not exist" do
      it "return a error message" do
        get "/api/suppliers/-1"

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Supplier not found")
      end
    end
  end

  describe "POST /api/suppliers" do
    context "when creating a new supplier with valid data" do
      let(:valid_author_params) { { supplier: { name: "New Supplier" } } }

      it "create supplier" do
        expect do
          post "/api/suppliers", params: valid_author_params
        end.to change(Supplier, :count).by(1)

        expect(response).to have_http_status :created
        expect(json_response["name"]).to eq("New Supplier")
      end
    end

    context "when creating a new supplier with invalid data" do
      let(:invalid_author_params) { { supplier: { name: "" } } }

      it "does not create supplier" do
        expect do
          post "/api/suppliers", params: invalid_author_params
        end.not_to change(Supplier, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end
end
