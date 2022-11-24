class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', counter_cache: true

  validates :title, :text, presence: true, length: { minimum: 5, maximum: 30 }
  validates :text, length: { maximum: 250 }

  def author_posts_counter
    author.increment(:posts_count)
  end

  def recent_comment
    comments.limit(5).order(created_at: :desc)
  end
end
