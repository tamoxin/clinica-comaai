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
  validates :active, inclusion: { in: [ true , false ] }
  
  validate :start_date_cannot_be_in_the_past
  validate :end_date_greater_than_start_date

  def start_date_cannot_be_in_the_past
    if startDate.present? && startDate < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end 
  
  def end_date_greater_than_start_date
    if endDate.present? && endDate <= startDate
      errors.add(:end_date, "has to be greater than Start date")
    end
  end 


end
