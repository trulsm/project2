# == Schema Information
#
# Table name: logs
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  project_id  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Logs < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :project

  validates :project_id, presence: true
  validates :name, presence: true

end
