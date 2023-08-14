# frozen_string_literal: true

class AddCnpjToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :cnpj, :string
  end
end
