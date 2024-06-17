# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:blog) { create(:blog) }

  describe "POST /blogs/:blog_id/comments" do
    context "with valid parameters" do
      let(:valid_comment_attributes) { attributes_for(:comment) }

      it "creates a new Comment" do
        expect {
          post blog_comments_path(blog), params: { comment: valid_comment_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the blog with success notice" do
        post blog_comments_path(blog), params: { comment: valid_comment_attributes }
        expect(response).to redirect_to(blog)
        expect(flash[:notice]).to eq('Comment was successfully created.')
      end
    end

    context "with invalid parameters" do
      let(:invalid_comment_attributes) { attributes_for(:comment, name: nil) }

      it "does not create a new Comment" do
        expect {
          post blog_comments_path(blog), params: { comment: invalid_comment_attributes }
        }.to_not change(Comment, :count)
      end

      it "redirects to the blog with alert message" do
        post blog_comments_path(blog), params: { comment: invalid_comment_attributes }
        expect(response).to redirect_to(blog)
        expect(flash[:alert]).to eq('Error creating comment.')
      end
    end
  end
end
