# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Suppliers", type: :request do
  let!(:suppliers) { create_list(:supplier, 5) }

  describe "GET /api/suppliers" do
    it "returns a list of suppliers" do
      get api_suppliers_path

      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(suppliers.length)

      mapped_suppliers = suppliers.map do |supplier|
        { "id" => supplier.id, "name" => supplier.name, "cnpj" => supplier.cnpj }
      end

      json_response.each do |supplier|
        expect(mapped_suppliers).to include(supplier)
      end
    end
  end

  describe "GET /api/suppliers/:id" do
    context "when supplier exist" do
      let(:supplier) { suppliers.first }
      let(:expected_response) do
        { "id" => json_response["id"], "name" => supplier.name, "cnpj" => supplier.cnpj }
      end

      it "returns a supplier" do
        get api_supplier_path(supplier)

        expect(response).to have_http_status(:ok)
        expect(json_response).to include(expected_response)
      end
    end

    context "when supplier does not exist" do
      it "return a error message" do
        get api_supplier_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Supplier not found.")
      end
    end
  end

  describe "POST /api/suppliers" do
    context "when creating a new supplier with valid data" do
      let(:supplier_attrs) { attributes_for(:supplier) }
      let(:valid_supplier_params) { { supplier: supplier_attrs } }
      let(:expected_response) do
        { "id" => json_response["id"], "name" => supplier_attrs[:name], "cnpj" => supplier_attrs[:cnpj] }
      end

      it "create supplier" do
        expect do
          post api_suppliers_path, params: valid_supplier_params
        end.to change(Supplier, :count).by(1)

        expect(response).to have_http_status :created
        expect(json_response).to include(expected_response)
      end
    end

    context "when creating a new supplier with invalid data" do
      let(:invalid_supplier_params) { { supplier: { name: "" } } }

      it "does not create supplier" do
        expect do
          post api_suppliers_path, params: invalid_supplier_params
        end.not_to change(Supplier, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "PATCH/PUT /api/suppliers/:id" do
    context "when try to update the supplier with valid data" do
      let(:supplier) { suppliers.first }
      let(:supplier_attrs) { attributes_for(:supplier) }
      let(:valid_supplier_params) { { supplier: supplier_attrs } }
      let(:expected_response) do
        { "id" => json_response["id"], "name" => supplier_attrs[:name], "cnpj" => supplier_attrs[:cnpj] }
      end

      it "the supplier will be updated" do
        patch api_supplier_path(supplier), params: valid_supplier_params
        supplier.reload

        expect(response).to have_http_status :ok
        expect(json_response).to include(expected_response)
      end
    end

    context "when try to update the supplier with invalid data" do
      let(:supplier) { suppliers.first }
      let(:invalid_supplier_params) { { supplier: { name: "" } } }

      it "the supplier will not be updated" do
        expect do
          patch api_supplier_path(supplier), params: invalid_supplier_params
        end.not_to change(supplier, :name)
        supplier.reload

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end

  describe "DELETE /api/suppliers/:id" do
    context "when supplier exists" do
      let(:supplier) { suppliers.first }

      it "the supplier will be deleted" do
        expect do
          delete api_supplier_path(supplier)
        end.to change(Supplier, :count).by(-1)
        expect(response).to have_http_status :no_content
      end
    end

    context "when supplier does not exists" do
      it "return an error message" do
        delete api_supplier_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to include("Supplier not found")
      end
    end

    context "when deleting supplier fails" do
      let!(:supplier) { suppliers.last }

      it "we received the status and error message correctly" do
        allow_any_instance_of(Supplier).to receive(:destroy).and_return(false)

        delete api_supplier_path(supplier)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the supplier.")
      end
    end
  end
end
