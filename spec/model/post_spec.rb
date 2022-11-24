require 'rails_helper'

describe Post, type: :model do
  let(:new_user) do
    User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  end
  subject { Post.new(author: new_user, title: 'Hello', text: 'This is my first post') }
  before { subject.save }

  describe 'Association' do
    it { should belong_to(:author) }
  end

  describe 'Validation' do
    it 'Title should not be empty' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'Title should not be too long' do
      subject.title = 'a' * 35
      expect(subject).to_not be_valid
    end

    it 'Text should not be too short' do
      subject.text = 'a'
      expect(subject).to_not be_valid
    end

    it 'Text Should not exceed 250 characters' do
      subject.text = 'a' * 300
      expect(subject).to_not be_valid
    end

    it 'Comments Counter must be an integer greater than or equal to zero' do
      expect(subject.comments_count).to be >= 0
    end

    it 'Likes Counter must be an integer greater than or equal to zero' do
      expect(subject.likes_count).to be >= 0
    end
  end

  describe 'Model methods test' do
    it 'Test to return recent comments' do
    end
  end
end
