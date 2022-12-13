require 'rails_helper'

RSpec.describe UsersController, type: :request do
  subject { User.create(id: '2', name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }
  it 'Response index route to be successful' do
    get users_path
    expect(response).to be_successful
  end

  it 'Response show route to be successful' do
    get user_path(subject.id)
    expect(response).to be_successful
  end

  it 'Index route returns a 200 status' do
    get users_path
    expect(response).to have_http_status(:ok)
  end

  it 'Show route returns a 200 status' do
    get user_path(subject.id)
    expect(response).to have_http_status(:ok)
  end

  it 'Renders the index route template' do
    get users_path
    expect(response).to render_template('index')
  end

  it 'Renders the show route template' do
    get user_path(subject.id)
    expect(response).to render_template('show')
  end
end
