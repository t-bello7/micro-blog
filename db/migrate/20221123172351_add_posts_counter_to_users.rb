class AddPostsCounterToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :posts_count, :integer, :default => 0
  end
end
