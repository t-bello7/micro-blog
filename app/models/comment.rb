class Comment < ApplicationRecord
  # after_save :post_comment_counter
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: true

  validates :text, presence: true, length: { maximum: 100 }

  def post_comment_counter
    post.increment!(:comments_count)
  end
end
