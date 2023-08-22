# frozen_string_literal: true

module IsbnGenerator
  def self.isbn_thirteen
    first_12_digits = generate_first_12_digits
    check_digit = calculate_check_digit(first_12_digits)

    "#{first_12_digits}#{check_digit}"
  end

  def self.generate_first_12_digits
    12.times.map { rand(10) }.join
  end

  def self.calculate_check_digit(first_12_digits)
    (10 - modulus_of_sum(first_12_digits)) % 10
  end

  def self.modulus_of_sum(first_12_digits)
    first_12_digits.each_char.each_with_index.sum { |digit, index| digit.to_i * (index.odd? ? 3 : 1) } % 10
  end

  private_class_method :generate_first_12_digits, :calculate_check_digit, :modulus_of_sum
end
