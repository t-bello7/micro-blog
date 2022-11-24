class Like < ApplicationRecord
    belongs_to :author, class_name: "User"
    belongs_to :post

    def posts_likes_counter
        self.posts.likes_count = self.post.likes.length
    end
end
