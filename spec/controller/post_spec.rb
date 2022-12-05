require 'rails_helper'

describe PostsController, type: :controller do
  render_views
  before(:each) do
    subject = User.create(id: '2', name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Mexico.')
    Post.create(id: '2', author: subject, title: 'Hello', text: 'This is my first post')
  end
  it 'returns a successful response' do
    expect(get: '/users/2/posts').to route_to(controller: 'posts', action: 'index', user_id: '2')
  end

  it 'renders the index template' do
    get :index, params: { user_id: 2 }
    expect(response).to render_template('index')
  end

  it 'renders the show template of posts' do
    get :show, params: { user_id: 2, id: 2 }
    expect(response).to render_template('posts/show')
  end
end
