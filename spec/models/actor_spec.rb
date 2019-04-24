require "rails_helper"

describe Actor, "#filmography" do
  it "returns the films that the actor appeared in", points: 1 do
    actor = Actor.new
    actor.save

    first_movie = Movie.new
    first_movie.save

    second_movie = Movie.new
    second_movie.save

    third_movie = Movie.new
    third_movie.save

    fourth_movie = Movie.new
    fourth_movie.save

    fifth_movie = Movie.new
    fifth_movie.save

    first_character = Character.new
    first_character.actor_id = actor.id
    first_character.movie_id = first_movie.id
    first_character.save

    second_character = Character.new
    second_character.actor_id = actor.id
    second_character.movie_id = third_movie.id
    second_character.save

    third_character = Character.new
    third_character.actor_id = actor.id
    third_character.movie_id = fifth_movie.id
    third_character.save

    expect(actor.filmography).to match_array([first_movie, third_movie, fifth_movie])
  end
end
