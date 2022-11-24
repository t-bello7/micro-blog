require 'rails_helper'

describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }

  it 'Name should not be empty' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Name should not be too long' do
    subject.name = 'a' * 35
    expect(subject).to_not be_valid
  end

  it 'Bio should not be too short' do
    subject.bio = 'a'
    expect(subject).to_not be_valid
  end

  it 'Posts Counter must be an integer greater than or equal to zero' do
    expect(subject.posts_count).to be >= 0
  end

  describe 'Model methods test' do
    it 'Test to return recent posts' do
    end
  end
end
