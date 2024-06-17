# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:blog) { create(:blog) }

  describe 'validations' do
    context 'invalid objects' do
      it 'validates presence of title' do
        blog.title = nil
        expect(blog).to be_invalid
        expect(blog.errors.full_messages[0]).to eq('Title can\'t be blank')
      end

      it 'validates presence of content' do
        blog.content = nil
        expect(blog).to be_invalid
        expect(blog.errors.full_messages[0]).to eq('Content can\'t be blank')
      end

      it 'validates inclusion of status' do
        blog.status = 'invalid'
        expect(blog).to be_invalid
        expect(blog.errors.full_messages[0]).to eq('Status is not included in the list')
      end
    end

    context 'valid objects' do
      it 'is valid' do
        expect(blog).to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      blog_association = Blog.reflect_on_association(:user)
      expect(blog_association.macro).to eq(:belongs_to)
    end
  end
end
