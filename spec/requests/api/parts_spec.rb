# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Parts", type: :request do
  let!(:supplier) { create(:supplier) }
  let!(:parts) { create_list(:part, 3, supplier: supplier) }
  let!(:valid_data) { { part: { part_number: rand(1000..9999).to_s, supplier_id: supplier.id } } }

  describe "GET /api/parts" do
    context "when trying to list all parts" do
      it "they are successfully listed" do
        get api_parts_path

        expect(response).to have_http_status :ok

        part_ids = parts.pluck(:id)
        part_numbers = parts.pluck(:part_number)
        json_response.each do |part|
          expect(part_ids).to include(part["id"])
          expect(part_numbers).to include(part["number"])
        end
      end
    end
  end

  describe "GET /api/parts/:id" do
    context "when trying to show a specific part" do
      it "it is displayed correctly" do
        part = parts.first
        get api_part_path(part)

        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(part.id)
        expect(json_response["number"]).to eq(part.part_number)
      end
    end

    context "when trying to display a part that does not exist" do
      it "we received the status and message correctly" do
        get api_part_path(-1)

        expect(response).to have_http_status :not_found
        expect(json_response["message"]).to eq("Part not found.")
      end
    end
  end

  describe "POST /api/parts" do
    context "when trying to create an part with valid data" do
      it "it will be created successfully" do
        post api_parts_path, params: valid_data

        expect(response).to have_http_status :created
        expect(json_response["id"]).to be_present
        expect(json_response["number"]).to eq(valid_data[:part][:part_number])
        expect(json_response["supplier"]["id"]).to eq(supplier.id)
        expect(json_response["supplier"]["name"]).to eq(supplier.name)
      end
    end

    context "when trying to create an part with invalid data" do
      let!(:invalid_data) { { part: { part_number: "", supplier_id: nil } } }
      it "we received the status and message correctly" do
        post api_parts_path, params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Part number can't be blank")
        expect(json_response["errors"]).to include("Supplier must exist")
      end
    end
  end

  describe "PATCH /api/parts/:id" do
    context "when trying to update an part with valid data" do
      let!(:assemblies) { create_list(:assembly, 3) }
      let!(:valid_data) { { part: { part_number: rand(1000..9999), assembly_ids: assemblies.pluck(:id) } } }

      it "the part is updated successfully" do
        part = parts.last
        patch api_part_path(part), params: valid_data

        part.reload
        expect(response).to have_http_status :ok
        expect(json_response["id"]).to eq(part.id)
        expect(json_response["number"]).to eq(part.part_number)
      end
    end

    context "when trying to change the supplier that is readonly" do
      let!(:new_supplier) { create(:supplier) }
      let!(:invalid_data) { { part: { supplier_id: new_supplier.id } } }

      it "the part will not be updated" do
        part = parts.last
        patch api_part_path(part), params: invalid_data

        part.reload
        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Supplier cannot be updated")
        expect(part.id).not_to eq(new_supplier.id)
      end
    end

    context "when trying to change the part name to an empty value" do
      let!(:invalid_data) { { part: { part_number: "" } } }

      it "we received the status and message correctly" do
        part = parts.last
        patch api_part_path(part), params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to include("Part number can't be blank")
      end
    end

    context "when trying to update with a non-existing assembly" do
      let!(:invalid_data) { { part: { assembly_ids: [-1] } } }

      it "we received the status and message correctly" do
        part = parts.last
        patch api_part_path(part), params: invalid_data

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"]).to eq("One or more assemblies not found.")
      end
    end
  end

  describe "DELETE /api/parts/:id" do
    context "when trying to delete a part and we are successful" do
      it "we receive the correct status" do
        part = parts.last
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
      it "we received the status and error message correctly" do
        allow_any_instance_of(Part).to receive(:destroy).and_return(false)

        part = parts.last
        delete api_part_path(part)

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["message"]).to eq("Failed to delete the part.")
      end
    end
  end
end
