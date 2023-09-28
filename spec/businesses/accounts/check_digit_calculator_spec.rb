# frozen_string_literal: true

require "rails_helper"

RSpec.describe Accounts::CheckDigitCalculator do
  describe ".call" do
    context "when called with an account number" do
      it "returns a digit between 0 and 9" do
        check_digit = Accounts::CheckDigitCalculator.call(22_222)

        expect((0..9).cover?(check_digit.to_i)).to be true
      end
    end
  end
end
