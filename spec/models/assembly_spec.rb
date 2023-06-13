# frozen_string_literal: true

require "rails_helper"

RSpec.describe Assembly, type: :model do
  describe "validations" do
    let(:assembly) { build(:assembly) }

    context "when name is present" do
      it "assembly creation is valid" do
        expect(assembly).to be_valid
      end
    end

    context "when name is not present" do
      let(:assembly) { build(:assembly, name: nil) }
      it "assembly creation is invalid" do
        expect(assembly).to be_invalid
      end
    end
  end
end
