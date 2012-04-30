class RemoveDescriptionFromLogs < ActiveRecord::Migration
  def change
    remove_column :logs, :description, :string
  end
end
