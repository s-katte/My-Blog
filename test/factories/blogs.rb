FactoryBot.define do
  factory :blog do
    title { 'Title' }
    content { 'sample content' }
    status { 'DRAFT' }
    published_date { DateTime.now }
    user
  end
end
