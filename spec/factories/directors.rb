# == Schema Information
#
# Table name: directors
#
#  id         :integer          not null, primary key
#  dob        :date
#  name       :string
#  bio        :text
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Copy this file into your spec/support folder; create one if you don't have it.
# https://github.com/firstdraft/increasing_random/blob/master/increasing_random.rb


FactoryBot.define do
  factory :director do
    sequence(:dob) { |n| "Some fake dob #{n}" }
    sequence(:name) { |n| "Some fake name #{n}" }
    sequence(:bio) { |n| "Some fake bio #{n}" }
    sequence(:image_url) { |n| "Some fake image url #{n}" }
  end
end
