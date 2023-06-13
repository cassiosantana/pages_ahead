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
  end
end
