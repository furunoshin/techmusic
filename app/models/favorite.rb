class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  def self.ranking
    self.group(:post_id).order('count_item_id DESC').limit(10).count(:post_id)
  end
end
