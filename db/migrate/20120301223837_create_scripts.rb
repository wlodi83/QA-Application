class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.string :title
      t.text :description
      t.text :query

      t.timestamps
    end
  end
end
