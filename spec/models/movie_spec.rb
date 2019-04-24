require "rails_helper"

describe Movie, ".first_by_title" do
  it "returns the first row matching the title", points: 2 do
    first_movie = Movie.new
    first_movie.title = "First movie"
    first_movie.save

    second_movie = Movie.new
    second_movie.title = "Second movie"
    second_movie.save

    third_movie = Movie.new
    third_movie.title = "Third movie"
    third_movie.save

    expect(Movie.first_by_title("Second movie")).to eq(second_movie)
  end
end

describe Movie, ".last_decade" do
  it "returns the movies from within the last 10 years", points: 3 do
    first_movie = Movie.new
    first_movie.year = 2019
    first_movie.save

    second_movie = Movie.new
    second_movie.year = 2007
    second_movie.save

    third_movie = Movie.new
    third_movie.year = 2014
    third_movie.save

    fourth_movie = Movie.new
    fourth_movie.year = 1994
    fourth_movie.save

    expect(Movie.last_decade).to match_array([first_movie, third_movie])
  end
end

describe Movie, ".short" do
  it "returns movies whose durations are less than 90 minutes", points: 2 do
    first_movie = Movie.new
    first_movie.duration = 95
    first_movie.save

    second_movie = Movie.new
    second_movie.duration = 85
    second_movie.save

    third_movie = Movie.new
    third_movie.duration = 185
    third_movie.save

    fourth_movie = Movie.new
    fourth_movie.duration = 175
    fourth_movie.save

    expect(Movie.last_decade).to match_array([second_movie])
  end
end

describe Movie, ".long" do
  it "returns movies whose durations are greater than 180 minutes", points: 2 do
    first_movie = Movie.new
    first_movie.duration = 95
    first_movie.save

    second_movie = Movie.new
    second_movie.duration = 85
    second_movie.save

    third_movie = Movie.new
    third_movie.duration = 185
    third_movie.save

    fourth_movie = Movie.new
    fourth_movie.duration = 175
    fourth_movie.save

    expect(Movie.last_decade).to match_array([third_movie])
  end
end

describe Movie, ".directed_by" do
  it "returns movies directed by the director with the provided ID", points: 3 do
    first_movie = Movie.new
    first_movie.director_id = 12
    first_movie.save

    second_movie = Movie.new
    second_movie.director_id = 42
    second_movie.save

    third_movie = Movie.new
    third_movie.director_id = 42
    third_movie.save

    fourth_movie = Movie.new
    fourth_movie.director_id = 101
    fourth_movie.save

    expect(Movie.directed_by(42)).to match_array([second_movie, third_movie])
  end
end

describe Movie, "#director" do
  it "returns the director of the movie", points: 3 do
    director = Director.new
    director.save

    movie = Movie.new
    movie.director_id = director.id
    movie.save

    expect(movie.director).to eq(director)
  end
end

describe Movie, "#characters" do
  it "returns the characters that belong to the movie", points: 3 do
    movie = Movie.new
    movie.save

    other_movie = Movie.new
    other_movie.save

    first_character = Character.new
    first_character.movie_id = movie.id
    first_character.save

    second_character = Character.new
    second_character.movie_id = other_movie.id
    second_character.save

    third_character = Character.new
    third_character.movie_id = movie.id
    third_character.save

    fourth_character = Character.new
    fourth_character.movie_id = other_movie.id
    fourth_character.save

    fifth_character = Character.new
    fifth_character.movie_id = movie.id
    fifth_character.save

    expect(movie.filmography).to match_array([first_character, third_character, fifth_character])
  end
end

describe Movie, "#cast" do
  it "returns the actors that appeared in the movie", points: 1 do
    movie = Movie.new
    movie.save

    first_actor = Actor.new
    first_actor.save

    second_actor = Actor.new
    second_actor.save

    third_actor = Actor.new
    third_actor.save

    fourth_actor = Actor.new
    fourth_actor.save

    fifth_actor = Actor.new
    fifth_actor.save

    first_character = Character.new
    first_character.movie_id = movie.id
    first_character.actor_id = first_actor.id
    first_character.save

    second_character = Character.new
    second_character.movie_id = movie.id
    second_character.actor_id = third_actor.id
    second_character.save

    third_character = Character.new
    third_character.movie_id = movie.id
    third_character.actor_id = fifth_actor.id
    third_character.save

    expect(movie.cast).to match_array([first_actor, third_actor, fifth_actor])
  end
end
