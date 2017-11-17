class Student < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => :group_id
  
end
