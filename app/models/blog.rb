# frozen_strint_literal: true

class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :content, presence: true
  validates :status, inclusion: { in: %w(DRAFT PUBLISHED) }
end
