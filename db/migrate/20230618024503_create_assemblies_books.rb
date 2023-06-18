# frozen_string_literal: true

class CreateAssembliesBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :assemblies_books do |t|
      t.references :assembly, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
