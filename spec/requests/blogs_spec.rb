require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user) { create(:user) }
  let(:blog) { create(:blog, user: user) }
  let!(:published_blog) { create(:blog, title: "Published blog", status: 'PUBLISHED') }
  let!(:draft_blog) { create(:blog, title: "Draft blog", status: 'DRAFT') }

  describe "GET /blogs" do
    it "renders a successful response" do
      get blogs_path
      expect(response).to be_successful
    end

    it "renders a list of published blogs filtered by search" do
      get blogs_path(search: "Published")
      expect(response).to be_successful
      expect(response.body).to include(published_blog.title)
      expect(response.body).to_not include(draft_blog.title)
    end
  end

  describe "GET /blogs/:id" do
    it "renders a successful response" do
      get blog_path(blog)
      expect(response).to be_successful
    end
  end

  describe "GET /blogs/new" do
    context "when logged in" do
      before { sign_in user }

      it "renders a successful response" do
        get new_blog_path
        expect(response).to be_successful
      end
    end

    context "when not logged in" do
      it "redirects to the login page" do
        get new_blog_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /blogs" do
    before { sign_in user }

    context "with valid parameters" do
      it "creates a new Blog" do
        expect {
          post blogs_path, params: { blog: attributes_for(:blog) }
        }.to change(Blog, :count).by(1)
      end

      it "redirects to the created blog" do
        post blogs_path, params: { blog: attributes_for(:blog) }
        expect(response).to redirect_to(Blog.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Blog" do
        expect {
          post blogs_path, params: { blog: attributes_for(:blog, title: nil) }
        }.to_not change(Blog, :count)
      end

      it "renders a successful response (i.e., to display the 'new' template)" do
        post blogs_path, params: { blog: attributes_for(:blog, title: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "GET /blogs/:id/edit" do
    before { sign_in user }

    it "renders a successful response" do
      get edit_blog_path(blog)
      expect(response).to be_successful
    end
  end

  describe "PATCH /blogs/:id" do
    before { sign_in user }

    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Title" } }

      it "updates the requested blog" do
        patch blog_path(blog), params: { blog: new_attributes }
        blog.reload
        expect(blog.title).to eq("Updated Title")
      end

      it "redirects to the blog" do
        patch blog_path(blog), params: { blog: new_attributes }
        expect(response).to redirect_to(blog)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e., to display the 'edit' template)" do
        patch blog_path(blog), params: { blog: attributes_for(:blog, title: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /blogs/:id" do
    before { sign_in user }

    it "destroys the requested blog" do
      blog_to_delete = create(:blog, user: user)
      expect {
        delete blog_path(blog_to_delete)
      }.to change(Blog, :count).by(-1)
    end

    it "redirects to the blogs list" do
      delete blog_path(blog)
      expect(response).to redirect_to(blogs_url)
    end
  end

  describe "POST /blogs/:id/publish" do
    before { sign_in user }
    let(:draft_blog) { create(:blog, user: user, status: 'DRAFT') }

    it "publishes the requested blog" do
      post publish_blog_path(draft_blog)
      draft_blog.reload
      expect(draft_blog.status).to eq('PUBLISHED')
    end

    it "redirects to the published blog" do
      post publish_blog_path(draft_blog)
      expect(response).to redirect_to(blog_path(draft_blog))
    end
  end
end
