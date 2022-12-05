require 'rails_helper'

describe PostsController, type: :request do
  it 'returns a successful response' do
    get user_posts_path(1)
    expect(response).to have_http_status(:ok)
  end

  it 'returns a successful response' do
    get user_post_path(1, 1)
    expect(response).to have_http_status(:ok)
  end

  it 'renders the index template' do
    get user_posts_path(1)
    expect(response).to render_template('index')
  end

  it 'renders the show template of posts' do
    get user_post_path(1, 1)
    expect(response).to render_template('posts/show')
  end

  it 'renders the actual template of the index page' do
    get user_posts_path(1)
    expect(response.body).to match(/<h1> Here is a list of posts for a given user <h1>/)
  end

  it 'renders the actual template of the show page' do
    get user_post_path(1, 1)
    expect(response.body).to match(/<h1> Here is a single Post Page of a User <h1>/)
  end
end
