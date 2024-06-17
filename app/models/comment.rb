class Comment < ApplicationRecord
  belongs_to :blog
  validates :name, :content, presence: true
end
