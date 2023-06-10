# frozen_string_literal: true

require "rails_helper"

RSpec.describe Part, type: :model do
  describe "validations" do
    let(:supplier) { create(:supplier) }

    context "when part_number is present" do
      let(:parts) { create_list(:part, 3, supplier_id: supplier.id) }

      it "parts creation is valid" do
        parts.each { |part| expect(part).to be_valid }
      end
    end
  end
end
