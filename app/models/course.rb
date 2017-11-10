class Course < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :cfolders, dependent: :destroy

  # validates :code, presence: true
  # validates :name, presence: true
  # validates :description, presence: true
  # validates :professor_id, presence: true
  # validates :active, presence: true

end
