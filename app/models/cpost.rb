class Cpost < ApplicationRecord
  belongs_to :cfolder

  validates :title, presence: true
  validates :body, presence: true
  validates :link, presence: true

end
