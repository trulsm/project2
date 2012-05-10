class ExchangeDataRegVariable < ActiveRecord::Migration
	change_table :logs do |t|
	  t.remove :data_reg
	  t.float :float_entry
	end
end
