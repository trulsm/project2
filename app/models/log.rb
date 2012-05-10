# == Schema Information
#
# Table name: logs
#
#  id          :integer         not null, primary key
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  float_entry :float
#

class Log < ActiveRecord::Base
  attr_accessible :float_entry
  belongs_to :project

  validates :project_id, presence: true
  validates :float_entry, presence: true

  default_scope order: 'logs.created_at DESC'

end
