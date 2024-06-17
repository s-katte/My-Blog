# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    if @comment.save
      redirect_to @blog, notice: 'Comment was successfully created.'
    else
      redirect_to @blog, alert: 'Error creating comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content)
  end
end
