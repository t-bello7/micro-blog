require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:new_user) do
    User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  end

  let(:new_post) do
    Post.new(author: new_user, title: 'Hello', text: 'This is my first post')
  end

  subject { Comment.new(post: new_post.id, author: new_user, text: 'Hi Tom!') }
  before { subject.save }

  context 'Model Association' do
    it { should belong_to(:author) }
    it { should belong_to(:post) }
  end

  context 'Model Validation' do
    it 'Text should not be empty' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'Text should not exceed 100 characters' do
      subject.text = 'a' * 101
      expect(subject).to_not be_valid
    end
  end
end
