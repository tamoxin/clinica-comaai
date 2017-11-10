class Gpost < ApplicationRecord
  belongs_to :gfolder

  validates :title, presence: true
  validates :body, presence: true
  validates :link, presence: true

end
