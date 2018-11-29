class Post < ApplicationRecord
  belongs_to :user
 
  validates :title, presence: true, length: { maximum: 80 }
  validates :tag, length: { maximum: 120 } 
  validates :content, presence: true, length: { maximum: 255 }

  
  has_many :users
  has_many :favorites, dependent: :destroy
  
  def self.search(search)
    if search
    Post.where(['content LIKE ?', "%#{search}%"])
    else
    Post.all
    end
  end
end
