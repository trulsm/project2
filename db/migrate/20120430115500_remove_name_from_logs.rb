class RemoveNameFromLogs < ActiveRecord::Migration
  def change
    remove_column :logs, :name, :string
  end
end
