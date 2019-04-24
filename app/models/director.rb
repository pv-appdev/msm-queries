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

class Director < ApplicationRecord
end
