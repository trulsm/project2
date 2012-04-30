# == Schema Information
#
# Table name: logs
#
#  id         :integer         not null, primary key
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  data_reg   :integer
#

class Logs < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :project

  validates :project_id, presence: true
  validates :data_reg, presence: true

end
