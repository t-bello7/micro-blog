class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', counter_cache: true

  validates :title, :text, presence: true, length: { minimum: 5, maximum: 30 }
  validates :text, length: { maximum: 250 }

  validates :comments_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def author_posts_counter
    author.increment!(:posts_count)
  end

  def recent_comment
    comments.limit(5).order(created_at: :desc)
  end
end
