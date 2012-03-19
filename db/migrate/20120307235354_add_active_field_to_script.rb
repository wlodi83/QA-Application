class AddActiveFieldToScript < ActiveRecord::Migration
  def change
    add_column :scripts, :active, :boolean, :null => false
  end
end
