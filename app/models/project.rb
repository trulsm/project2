class Project < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 140}
  default_scope order: 'projects.created_at DESC'
end
