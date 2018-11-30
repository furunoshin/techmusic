class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :user_id , presence: true
  
  has_many :comment_favorites, dependent: :destroy
end
