class Cfolder < ApplicationRecord
  belongs_to :course
  has_many :cposts, dependent: :destroy

  validates :name, presence: true

end
