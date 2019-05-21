# == Schema Information
#
# Table name: actors
#
#  id         :integer          not null, primary key
#  dob        :date
#  name       :string
#  bio        :text
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Actor < ApplicationRecord
    def filmography
     my_movie_id = Character.where({:actor_id => self.id}).pluck(:movie_id)
     return Movie.where(:id => my_movie_id)
    end
    
end
