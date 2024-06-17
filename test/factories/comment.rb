# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    name { 'user 1' }
    content { 'sample content' }
    blog
  end
end
