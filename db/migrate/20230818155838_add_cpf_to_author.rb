# frozen_string_literal: true

class AddCpfToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :cpf, :string
  end
end
