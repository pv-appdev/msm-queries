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

class Movie < ApplicationRecord
    
    def Movie.first_by_title(some_title)
    return self.where({ :title => some_title }).first
    end
    
    def Movie.short
    return Movie.where({:duration => (0..90)})
    end
    
    def Movie.long
    return Movie.where.not({:duration => (0..180)})
    end
  
  def Movie.last_decade
    return Movie.where({:year => (2009..2019)})
  end
  
  def Movie.directed_by(some_ID)
    return Movie.where({ :director_id => some_ID })
  end
  
  def director
     return Director.where(:id => self.director_id).first
  end
  
  def characters
     return Character.where(:movie_id => self.id)
  end
  
  def cast
    my_cast = Character.where(:movie_id=>self.id).pluck(:actor_id)
    return Actor.where({:id=>my_cast})
  end
  
end
