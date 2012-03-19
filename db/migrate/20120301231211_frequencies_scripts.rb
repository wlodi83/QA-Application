class FrequenciesScripts < ActiveRecord::Migration
  def change
    create_table :frequencies_scripts, :id => false do |t|
      t.references :frequency
      t.references :script
      t.timestamps
    end
  end
end
