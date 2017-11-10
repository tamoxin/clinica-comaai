class Group < ApplicationRecord
  belongs_to :course
  has_many :gfolders, dependent: :destroy

  has_many :students
  has_many :users, through: :students

  validates :code, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :startDate, presence: true
  validates :endDate, presence: true
  validates :active, presence: true


end
