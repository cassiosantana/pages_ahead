# frozen_string_literal: true

class AddCheckDigitToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :check_digit, :string
  end
end
