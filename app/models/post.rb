class Post < ApplicationRecord
    has_many :comments
    has_many :likes
    belongs_to :author, class_name: "User", counter_cache: true
  
    def author_posts_counter
        author.increment(:posts_count)
    end

    def recent_comment
        self.comments.limit(5).order(created_at: :desc)
    end
end
