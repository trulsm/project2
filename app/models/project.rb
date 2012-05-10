# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#

class Project < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :user
  has_many :logs, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 140}
  default_scope order: 'projects.created_at DESC'
end
