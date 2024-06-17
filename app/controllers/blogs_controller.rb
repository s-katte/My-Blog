# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      blogs = Blog.where(status: 'PUBLISHED').where("title LIKE ?", "%#{params[:search]}%").order(created_at: :desc)
    else
      blogs = Blog.where(status: 'PUBLISHED').order(created_at: :desc)
    end

    @pagy, @blogs = pagy(blogs)
  end

  def show
    @blog
  end

  def new
    @blog = current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blog_params.merge(status: 'DRAFT'))
    if @blog.save
      redirect_to @blog, notice: 'blog was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'blog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'blog was successfully destroyed.'
  end

  def my_blogs
    @pagy, @blogs = pagy(current_user.blogs.order('created_at ASC'))
  end

  def publish
    @blog = Blog.find_by(id: params[:id])
    @blog.update(status: 'PUBLISHED', published_date: DateTime.now)
    redirect_to blog_path(@blog)
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end
end
