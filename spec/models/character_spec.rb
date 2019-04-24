require "rails_helper"

describe Character, ".in_movie" do
  it "returns characters in the movie with the provided ID", points: 2 do
    first_character = Character.new
    first_character.movie_id = 12
    first_character.save

    second_character = Character.new
    second_character.movie_id = 42
    second_character.save

    third_character = Character.new
    third_character.movie_id = 42
    third_character.save

    fourth_character = Character.new
    fourth_character.movie_id = 101
    fourth_character.save

    expect(Character.in_movie(42)).to match_array([second_character, third_character])
  end
end

describe Character, ".acted_by" do
  it "returns characters played by the actor with the provided ID", points: 2 do
    first_character = Character.new
    first_character.actor_id = 12
    first_character.save

    second_character = Character.new
    second_character.actor_id = 42
    second_character.save

    third_character = Character.new
    third_character.actor_id = 42
    third_character.save

    fourth_character = Character.new
    fourth_character.actor_id = 101
    fourth_character.save

    expect(Character.acted_by(42)).to match_array([second_character, third_character])
  end
end
