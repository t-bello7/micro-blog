class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: true

  def posts_likes_counter
    post.increment!(:likes_count)
  end
end
