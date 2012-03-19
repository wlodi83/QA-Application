class AddErrorMessageToScript < ActiveRecord::Migration
  def change
    add_column :scripts, :err_message, :text
  end
end
