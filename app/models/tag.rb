class Tag < ApplicationRecord
  belongs_to :post
  validates :tag, presence: true
end
