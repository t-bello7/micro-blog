require 'rails_helper'

describe PostsController, type: :controller do
  render_views

  it 'returns a successful response' do
    expect(get: '/users/1/posts').to route_to(controller: 'posts', action: 'index', user_id: '1')
  end

  it 'renders the index template' do
    get :index, params: { user_id: 1 }
    expect(response).to render_template('index')
  end

  it 'renders the show template of posts' do
    get :show, params: { user_id: 1 }
    expect(response).to render_template('post')
  end


  it "renders the actual template of the index page" do
    get :index, params: { user_id: 1 }
    expect(response.body).to match /<h1> Here is a list of posts for a given user <h1>/
  end

  it "renders the actual template of the show page" do 
    get :show, params: { id: 1, user_id: 1 }
    expect(response.body).to match /<h1> Here is a single Post Page of a User <h1>
    /
  end
end
