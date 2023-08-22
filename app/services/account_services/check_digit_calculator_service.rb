# frozen_string_literal: true

module AccountServices
  class CheckDigitCalculatorService < ApplicationService
    def initialize(account_number)
      super
      @account_number = account_number.to_i
    end

    def call
      total = calculate_total(@account_number)
      calculate_check_digit(total)
    end

    private

    def calculate_total(account_number)
      account_number.digits.each_with_index.sum do |digit, index|
        index.odd? ? double_and_subtract(digit) : digit
      end
    end

    def double_and_subtract(digit)
      double = digit * 2
      double > 9 ? double - 9 : double
    end

    def calculate_check_digit(total)
      ((10 - total % 10) % 10).to_s
    end
  end
end
