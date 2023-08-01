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
        expect(json_response["message"]).to eq("Supplier not found.")
      end
    end
  end

  describe "POST /api/suppliers" do
    context "when creating a new supplier with valid data" do
      let(:valid_supplier_params) { { supplier: { name: "New Supplier" } } }

      it "create supplier" do
        expect do
          post "/api/suppliers", params: valid_supplier_params
        end.to change(Supplier, :count).by(1)

        expect(response).to have_http_status :created
        expect(json_response["name"]).to eq("New Supplier")
      end
    end

    context "when creating a new supplier with invalid data" do
      let(:invalid_supplier_params) { { supplier: { name: "" } } }

      it "does not create supplier" do
        expect do
          post "/api/suppliers", params: invalid_supplier_params
        end.not_to change(Supplier, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "PATCH/PUT /api/suppliers/:id" do
    context "when try to update the supplier with valid data" do
      let!(:supplier) { create(:supplier) }
      let(:valid_supplier_params) { { supplier: { name: "Updated supplier" } } }

      it "the supplier will be updated" do
        patch "/api/suppliers/#{supplier.id}", params: valid_supplier_params

        expect(response).to have_http_status :ok

        supplier.reload
        expect(supplier.name).to eq("Updated supplier")
      end
    end

    context "when try to update the supplier with invalid data" do
      let!(:supplier) { create(:supplier) }
      let(:invalid_supplier_params) { { supplier: { name: "" } } }

      it "the supplier will not be updated" do
        expect do
          patch "/api/suppliers/#{supplier.id}", params: invalid_supplier_params
        end.not_to change(supplier, :name)
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "DELETE /api/suppliers/:id" do
    context "when supplier exists" do
      let!(:supplier) { create(:supplier) }

      it "the supplier will be deleted" do
        expect do
          delete "/api/suppliers/#{supplier.id}"
        end.to change(Supplier, :count).by(-1)
        expect(response).to have_http_status :ok
        expect(json_response["message"]).to eq("Supplier deleted successfully.")
      end
    end

    context "when supplier does not exists" do
      it "return an error message" do
        delete "/api/suppliers/-1"

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to include("Supplier not found")
      end
    end
  end
end