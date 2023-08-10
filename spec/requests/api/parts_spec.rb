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
  end
end
