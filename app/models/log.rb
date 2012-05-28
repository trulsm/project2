# == Schema Information
#
# Table name: logs
#
#  id          :integer         not null, primary key
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  float_entry :float
#  log_date    :date
#

class Log < ActiveRecord::Base
  attr_accessible :float_entry, :log_date
  belongs_to :project

  validates :project_id, presence: true
  validates :float_entry, presence: true
  validates :log_date, presence: true

  default_scope order: 'logs.created_at DESC'

end
