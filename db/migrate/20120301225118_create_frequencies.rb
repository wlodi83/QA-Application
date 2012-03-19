class CreateFrequencies < ActiveRecord::Migration
  def change
    create_table :frequencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
