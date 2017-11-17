class User < ApplicationRecord
  def full_name
    "#{firstName} #{lastName}"
  end

  has_many :students
  has_many :groups, through: :students

  before_save { self.username = username.downcase }
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { maximum: 16, minimum: 5 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 15, minimum: 8 }
  validates :userType, presence: true, inclusion: { in: %w(admin coordinator professor student) }
  validates :firstName, presence: true, length: { maximum: 20, minimum: 4 }, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, on: :create, message: "format: letters only. No signs/numbers allowed." }
  validates :lastName, presence: true, length: { maximum: 20, minimum: 5 }, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, on: :create, message: "format: letters only. No signs/numbers allowed." }
  validates :email, presence: true, length: { maximum: 35, minimum: 6 }, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :phone, presence: true, length: { maximum: 12, minimum: 10 }, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }
  validates :active, inclusion: { in: [ true, false ] }


end
