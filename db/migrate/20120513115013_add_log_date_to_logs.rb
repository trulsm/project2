class AddLogDateToLogs < ActiveRecord::Migration
	change_table(:logs) do |t|
	  t.column :log_date, :date
	end
end
