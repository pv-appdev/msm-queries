# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  year        :string
#  duration    :integer
#  description :text
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  director_id :integer
#

# Copy this file into your spec/support folder; create one if you don't have it.
# https://github.com/firstdraft/increasing_random/blob/master/increasing_random.rb


FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Some fake title #{n}" }
    sequence(:year) { |n| "Some fake year #{n}" }
    sequence(:duration) { |n| n }
    sequence(:description) { |n| "Some fake description #{n}" }
    sequence(:image_url) { |n| "Some fake image url #{n}" }
  end
end
