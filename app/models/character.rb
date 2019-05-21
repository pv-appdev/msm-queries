# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  actor_id   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Character < ApplicationRecord
    
    def Character.in_movie(some_ID)
    return Character.where({ :movie_id => some_ID })
    end
    
    def Character.acted_by(some_ID)
    return Character.where({ :actor_id => some_ID })
    end
    
end
