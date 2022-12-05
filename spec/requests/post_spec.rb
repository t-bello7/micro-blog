require 'rails_helper'

describe PostsController, type: :request do
  before(:each) do
    subject = User.create(id: '2', name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Mexico.')
    Post.create(id: '2', author: subject, title: 'Hello', text: 'This is my first post')
  end

  it 'returns a successful response' do
    get user_posts_path(2)
    expect(response).to have_http_status(:ok)
  end

  it 'returns a successful response' do
    get user_post_path(2, 2)
    expect(response).to have_http_status(:ok)
  end

  it 'renders the index template' do
    get user_posts_path(2)
    expect(response).to render_template('index')
  end

  it 'renders the show template of posts' do
    get user_post_path(2, 2)
    expect(response).to render_template('posts/show')
  end
end
