class CreateNewTableForLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :data_reg
      t.references :project
 
      t.timestamps
    end
 
    add_index :logs, :project_id
  end
end