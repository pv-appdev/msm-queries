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
  def age
    days_old = Date.today - self.dob
    years_old = days_old / 365
    return years_old.to_i
  end
  
  def Director.youngest
    return Director.order({ :dob => :desc }).first
  end
  
  def Director.eldest
    return Director.where.not({:dob=>nil}).order({:dob=>:asc}).first
  end

  
  def filmography
     return Movie.directed_by(self.id)
  end
  
end
