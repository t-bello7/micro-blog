require 'rails_helper'

RSpec.describe 'UsersPages', type: :feature do
  subject { User.create(id: '2', name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }

  context 'index page' do
    it 'User name is displayed on the page' do
      visit root_path(subject)
      expect(page).to have_content(subject.name)
    end

    it 'User photo is displayed on the page' do
      visit root_path(subject)
      expect(page.find('.user-photo')['src']).to have_content(subject.photo)
    end

    it 'Number of Posts is displayed on page' do
      visit root_path(subject)
      expect(page).to have_content('Number of Posts')
    end

    it 'Number of Posts for user is displayed' do
      visit root_path(subject)
      page.has_content?(subject.posts_count)
    end

    it 'Redirect to show particular user page' do
      visit root_path(subject)
      click_on 'Tom'
      expect(page.current_path).to eq user_path(subject)
    end
  end

  context 'show page' do
    it 'User profile picture is displayed' do
      visit user_path(subject)
      expect(page.find('.user-photo')['src']).to have_content(subject.photo)
    end

    it 'User username is displayed' do
      visit user_path(subject)
      expect(page).to have_content(subject.name)
    end

    it 'Number of Posts is displayed on page' do
      visit user_path(subject)
      expect(page).to have_content('Number of Posts')
    end

    it 'Number of Posts for User is displayed' do
      visit user_path(subject)
      expect(page).to have_content(subject.posts_count)
    end

    it 'Users Bio is displayed' do
      visit user_path(subject)
      expect(page).to have_content(subject.bio)
    end

    it 'Users 3 recent posts are displayed' do
      Post.create(id: '2', author: subject, title: 'Hello', text: 'This is my first post')
      Post.create(id: '3', author: subject, title: 'Hello', text: 'This is my first post')
      Post.create(id: '4', author: subject, title: 'Hello', text: 'This is my first post')
      visit user_path(subject)
      page.has_content?(subject.recent_post)
    end

    it 'See all posts button is displayed' do
      visit user_path(subject)
      expect(page).to have_button('See all posts')
    end

    it 'Redirect to show particular post' do
      post = Post.create(id: '2', author: subject, title: 'Hello', text: 'This is my first post')
      visit(user_path(subject))
      click_on 'Hello'
      expect(page.current_path).to eq user_post_path(subject, post)
    end

    it 'Redirect to show all users post' do
      Post.create(id: '2', author: subject, title: 'Hello', text: 'This is my first post')
      Post.create(id: '3', author: subject, title: 'Hello', text: 'This is my first post')
      Post.create(id: '4', author: subject, title: 'Hello', text: 'This is my first post')
      visit(user_path(subject))
      click_link 'See all posts'
      expect(page.current_path).to eq(user_posts_path(subject))
    end
  end
end
