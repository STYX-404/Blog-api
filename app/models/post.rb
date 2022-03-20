class Post < ApplicationRecord
  belongs_to :user
  has_many :tags
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true
end
