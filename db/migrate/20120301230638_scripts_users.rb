class ScriptsUsers < ActiveRecord::Migration
  def change
    create_table :scripts_users, :id => false do |t|
      t.references :script
      t.references :user
      t.timestamps
    end
  end
end
