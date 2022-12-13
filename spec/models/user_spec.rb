require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  before { subject.save }
  it { should have_many(:posts) }
  it { should have_many(:comments) }

  context 'Model Validation' do
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
      subject.posts_count = nil
      expect(subject).to_not be_valid
    end
  end

  context 'Model Methods Tests' do
    it 'Test to return recent posts' do
      expect(subject.recent_post).to eq(subject.posts.last(5))
    end
  end
end
