class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  validates :name, presence: true, length: { maximum: 30 }
  validates :bio, presence: true, length: { minimum: 15 }
  validates :posts_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def recent_post
    posts.limit(3).order(created_at: :desc)
  end

  def is?(requested_role)
    role == requested_role.to_s
  end
end
