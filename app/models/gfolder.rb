class Gfolder < ApplicationRecord
  belongs_to :group
  has_many :gposts, dependent: :destroy

  validates :name, presence: true

end
