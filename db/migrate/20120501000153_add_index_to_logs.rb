class AddIndexToLogs < ActiveRecord::Migration
  def change
  	add_index :logs, :project_id
  end
end
