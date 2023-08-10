# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Parts", type: :request do
  let!(:supplier) { create(:supplier) }
  let!(:parts) { create_list(:part, 3, supplier: supplier) }

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
end
