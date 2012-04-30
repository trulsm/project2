class AddDataRegToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :data_reg, :int
  end
end
