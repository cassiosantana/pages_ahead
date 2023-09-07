# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Parts", type: :request do
  let(:part_ids) { Part.pluck(:id) }
  let(:part_names) { Part.pluck(:name) }
  let(:part_numbers) { Part.pluck(:part_number) }
  let(:part_prices) { Part.pluck(:price) }

  describe "GET /api/parts" do
    before { create_list(:part, 3) }

    it "returns all parts" do
      get api_parts_path

      expect(response).to have_http_status :ok
      json_response.each do |part|
        expect(part_ids).to include(part["id"])
        expect(part_names).to include(part["name"])
        expect(part_numbers).to include(part["number"])
        expect(part_prices).to include(part["price"].to_d)
      end
    end
  end

  describe "GET /api/parts/:id" do
    let(:part) { create(:part) }

    context "when the part exists" do
      it "returns the part" do
        get api_part_path(part)

        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(part.id)
        expect(json_response["name"]).to eq(part.name)
        expect(json_response["number"]).to eq(part.part_number)
        expect(json_response["price"].to_d).to eq(part.price)
      end
    end

    context "when the part does not exist" do
      it "returns not found status and message" do
        get api_part_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Part not found.")
      end
    end
  end

  describe "POST /api/parts" do
    let(:supplier) { create(:supplier) }
    let(:valid_data) { { part: attributes_for(:part).merge(supplier_id: supplier.id) } }

    context "when data is valid" do
      it "creates a new part" do
        post api_parts_path, params: valid_data

        expect(response).to have_http_status :created
        expect(json_response["name"]).to eq(valid_data[:part][:name])
        expect(json_response["number"]).to eq(valid_data[:part][:part_number])
        expect(json_response["price"].to_d).to eq(valid_data[:part][:price])
        expect(json_response["supplier"]["id"]).to eq(valid_data[:part][:supplier_id])
        expect(json_response["supplier"]["name"]).to eq(supplier.name)
      end
    end

    context "when data is invalid" do
      let(:invalid_data) { { part: { part_number: "", supplier_id: nil } } }

      it "does not create a new part and returns error message" do
        post api_parts_path, params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Part number can't be blank", "Supplier must exist")
      end
    end
  end

  describe "PATCH /api/parts/:id" do
    context "when data is valid" do
      let(:part) { create(:part) }
      let(:assemblies) { create_list(:assembly, 3) }
      let(:valid_data) do
        {
          part: attributes_for(:part).except(:supplier).merge(assembly_ids: assemblies.pluck(:id))
        }
      end

      it "update the part" do
        patch api_part_path(part), params: valid_data

        part.reload
        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(part.id)
        expect(json_response["name"]).to eq(valid_data[:part][:name])
        expect(json_response["number"]).to eq(valid_data[:part][:part_number])
        expect(json_response["price"].to_d).to eq(valid_data[:part][:price])
        expect(json_response["supplier"]["id"]).to eq(part.supplier.id)
        expect(json_response["supplier"]["name"]).to eq(part.supplier.name)
      end
    end

    context "when trying to change the supplier" do
      let(:part) { create(:part) }
      let(:new_supplier) { create(:supplier) }
      let(:invalid_data) { { part: { supplier_id: new_supplier.id } } }

      it "the part will not be updated" do
        patch api_part_path(part), params: invalid_data

        part.reload
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Supplier cannot be updated")
        expect(part.supplier.id).not_to eq(new_supplier.id)
      end
    end

    context "when trying to change the part number to an empty value" do
      let(:part) { create(:part) }
      let(:invalid_data) { { part: { part_number: "" } } }

      it "we received the status and message correctly" do
        patch api_part_path(part), params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Part number can't be blank")
      end
    end

    context "when trying to update with a non-existing assembly" do
      let(:part) { create(:part) }
      let(:invalid_data) { { part: { assembly_ids: [-1] } } }

      it "we received the status and message correctly" do
        patch api_part_path(part), params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to eq("One or more assemblies not found.")
      end
    end
  end

  describe "DELETE /api/parts/:id" do
    context "when trying to delete a part and we are successful" do
      let(:part) { create(:part) }

      it "we receive the correct status" do
        delete api_part_path(part)

        expect(response).to have_http_status :no_content
      end
    end

    context "when trying to delete a part that does not exist" do
      it "we receive the correct status and message" do
        delete api_part_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to include("Part not found.")
      end
    end

    context "when deleting book fails" do
      let(:part) { create(:part) }

      it "we received the status and error message correctly" do
        allow_any_instance_of(Part).to receive(:destroy).and_return(false)

        delete api_part_path(part)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the part.")
      end
    end
  end
end
