require 'rails_helper'
RSpec.describe 'Post Pages', type: :feature do
    subject{ User.create(id: '2', name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')}
    before {subject.save}
    context 'Post index page' do
        it 'User profile page is displayed' do
            visit user_posts_path(subject)
            expect(page.find('.user-photo')['src']).to have_content(subject.photo)
        end
        it 'User username is displayed' do
            visit user_posts_path(subject)
            expect(page).to have_content(subject.name)
        end
        it 'User number of posts is displayed' do
            visit user_posts_path(subject)
            page.has_content?(subject.posts_count)
        end
        it 'Post Title is displayed' do
            post = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            visit user_posts_path(subject)
            expect(page).to have_content(post.title)
        end
        it 'Post bodies are displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            post_two = Post.create(id: '2', author: subject, title: 'Hello', text: 'This is my first post')
            post_there = Post.create(id: '3', author: subject, title: 'Hello', text: 'This is my first post')
            visit user_posts_path(subject)
            expect(page).to have_content(post_one.text)
            expect(page).to have_content(post_two.text)
            expect(page).to have_content(post_there.text)
        end
        it 'Post first comments is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            visit user_posts_path(subject)
            expect(page).to have_content(post_one.comments.first.text)
        end
        it 'Post number of comments is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            visit user_posts_path(subject)
            page.has_content?(post_one.comments_count)
        end
        it 'Post number of likes is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            Like.create(post: post_one, author: subject)
            visit user_posts_path(subject)
            page.has_content?(post_one.likes_count)
        end
        it 'A section for pagination is displayed' do
            visit user_posts_path(subject)
            page.has_selector?('.pagination')
        end
        it 'Redirect to a particular post page' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            visit user_posts_path(subject)
            click_on 'Hello'
            expect(page.current_path).to eq user_post_path(subject, post_one)
        end
    end
    context 'Post show page'  do
        it 'Post title is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            visit user_post_path(subject, post_one)
            expect(page).to have_content(post_one.title)
        end
        it 'Post author is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            visit user_post_path(subject, post_one)
            expect(page).to have_content(post_one.author.name)
        end
        it 'posts number of comments is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            Comment.create(post: post_one, author: subject, text: 'Hi Tom!')
            visit user_post_path(subject, post_one)
            page.has_content?(post_one.comments_count)
        end
        it 'posts number of likes is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            Like.new(post: post_one, author: subject)
            visit user_post_path(subject, post_one)
            page.has_content?(post_one.likes_count)
        end
        it 'Post body is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            visit user_post_path(subject, post_one)
            expect(page).to have_content(post_one.text)
        end
        it 'Username of each comments is displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            user_one = User.create(id: '3', name: 'Queens', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
            user_three = User.create(id: '4', name: 'Tesla', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
            comment_one = Comment.new(post: post_one, author: subject, text: 'Hi Tom!')
            comment_two = Comment.new(post: post_one, author: user_one, text: 'Hi Tom!')
            comment_three = Comment.new(post: post_one, author: user_three, text: 'Hi Tom!')
            visit user_post_path(subject, post_one)
            page.has_content?(comment_one.author)
            page.has_content?(comment_two.author)
            page.has_content?(comment_three.author)
        end
        it 'Comments are displayed' do
            post_one = Post.create(id: '5', author: subject, title: 'Hello', text: 'This is my first post')
            user_one = User.create(id: '3', name: 'Queens', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
            user_three = User.create(id: '4', name: 'Tesla', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
            comment_one = Comment.new(post: post_one, author: subject, text: 'Not your regular!')
            comment_two = Comment.new(post: post_one, author: user_one, text: 'Best at it!')
            comment_three = Comment.new(post: post_one, author: user_three, text: 'It only gets better')
            visit user_post_path(subject, post_one)
            page.has_content?(comment_one.text)
            page.has_content?(comment_two.text)
            page.has_content?(comment_three.text)
        end
    end
end