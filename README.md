# Must See Movies — Queries

## Objective

In this project, we'll practice using `.where` and other ActiveRecord query methods. (It would be good to have [the ActiveRecord Chapter](https://chapters.firstdraft.com/chapters/770#where) open in a tab for easy reference.) We're going to practice in the context of our familiar movie-related domain — Directors, Movies, Characters, and Actors.

## Setup

## Standard Workflow

 1. From [your Cloud9 repositories list](https://c9.io/account/repos), create a workspace [as usual](https://guides.firstdraft.com/starting-on-a-project-in-cloud9).
 1. Once created, set up the project by typing this at a Terminal prompt (`$`): `bin/setup`.
 1. Follow the [getting automated feedback](https://guides.firstdraft.com/getting-automated-feedback) workflow. Since we're not building user-facing interfaces yet, **ignore the parts of that guide** that say to "Run Project and Preview the live application" and "click through the target". Most of our projects will have these things, but not this one.

    When you're ready, you can run `rails grade` at a command prompt to test the methods that you're writing and see your score.

## Two important notes about `rails console`

 1. Sometimes when the output of a Ruby expression is very long, `rails console` is going to paginate it for you. You will have a `:` prompt when this is true, and you can hit <kbd>Return</kbd> to scroll through line by line, or <kbd>Space</kbd> to scroll through page by page.

    When you reach the end of the output, you'll see `(END)`.

    **To get back to the regular prompt so that you can enter your next command, just hit <kbd>q</kbd> at any time.**

 2. If you are in `rails console` and then make a change to a model (for example, you define a new method or fix a syntax error), then, annoyingly, **you have to `exit` and then start a new `rails console`** to pick up the new logic. Or, you can use the `reload!` method.

## Starting out

Open a Terminal tab, launch a `rails console` session, and then try the following:

```ruby
Director.count
Movie.count
Character.count
Actor.count
```

You'll see that I have already created these 4 tables; they exist, but right now there are no rows in any of them. You can see what columns are in each table by:

 - Typing just the class name into `rails console`, e.g.

    ```
    [2] pry(main)> Character
    => Character(id: integer, movie_id: integer, actor_id: integer, name: string, created_at: datetime, updated_at: datetime)
    ```
 - Looking at the comments at the top of the model file, e.g. `app/models/movie.rb`. (These comments are auto-generated and kept up to date by the excellent [annotate gem](https://github.com/ctran/annotate_models).)

## CRUD some records

You can enter some rows into tables using the [ActiveRecord methods that you learned](https://chapters.firstdraft.com/chapters/770):

```ruby
d = Director.new
d.name = "Anthony Russo"
d.dob = "February 3, 1970"
d.save
```

You can check out your newly saved director:

```ruby
Director.last
```

Assuming the new director's ID number is `42`, we can add a new movie:

```ruby
m = Movie.new
m.title = "Avengers: Infinity War"
m.year = 2018
m.duration = 149
m.director_id = 42
m.save
```

Etc. We could add a bunch of movies — perhaps even the entire IMDB Top 250 — this way, by adding directors and actors first, then adding movies, and finally adding characters to join movies and actors.

Go ahead and add the IMDB Top 250 by hand with `.new`, `.save`, etc..... just kidding! That would take forever. In the real world, _someone_ would have to add all of our data, whether it's us, or our employees, or a rake task that pulls from an API, or our users (through forms in their browser, obviously, not through `rails console`).

But for now I've provided a rake task, `dummy:reset`, that will populate your tables for you quickly. You can go check it out if you like in `lib/tasks/dummy.rake`, but there's not much to see. It just creates a bunch of rows in each table with data that I web scraped from IMDB. Run the task with the following command-line command (you should _not_ be at `pry(main)>` when you run this, you should be at the `$` prompt — open a new Terminal tab if you need to):

```bash
rails dummy:reset
```

You should see output like

```bash
There are 34 directors in the database
There are 50 movies in the database
There are 652 actors in the database
There are 722 characters in the database
```

You can verify this yourself by `.count`ing each table in `rails console`.

## Appetizer queries

Okay! Now that we have some data to play around with, let's practice answering some queries in `rails console`.

### Finding a movie by title

In what year was the movie `"The Dark Knight"` released?

 - Use the [`.where` method](https://chapters.firstdraft.com/chapters/770#where). It is everything.
 - Remember that [`.where` always returns a collection, not a single row](https://chapters.firstdraft.com/chapters/770#where-always-returns-a-collection-not-a-single-row).

### Other queries

 - How many movies in our table are from [before](https://chapters.firstdraft.com/chapters/770#less-than-or-greater-than) the year 2000?
 - Who is the youngest director in our table?
 - How many directors in our table are less than 55 years old? What are their names?
 - How many films in our table were directed by Francis Ford Coppola?
 - How many films did Morgan Freeman appear in?

## Defining an instance method

Recall that one of the best things about defining [our own classes](https://chapters.firstdraft.com/chapters/769) in Ruby is that we get to empower them with methods, in addition to just storing data (as we would in a `Hash`). So, for example, we could add a method to the `Director` class that would return their current age today:

```ruby
class Director < ApplicationRecord
  def age
    days_old = Date.today - self.dob
    years_old = days_old / 365

    return years_old.to_i
  end
end
```

Go ahead and add this method to your `Director` model, and then test it out in `rails console`.

**Since we made a change to our models, we have to reload the `rails console`.** You can do that by

 - `exit`ing the `rails console` and launching it again
 - or opening a new Terminal tab and launching a new session
 - or using the `reload!` command

But now, you should be able to do something like this:

```ruby
d = Director.order({ :dob => :desc }).first
d.age
```

## Defining a class method

We can also define methods that we call on the _class_ itself, rather than on individual members of the class. `.order`, `.count`, etc, are examples of **class**-level methods. We can define our own class methods putting the name of the class after the `def` keyword:

```
class Director < ApplicationRecord
  def Director.say_hello
    p "Hello, I'm a class method"
  end

  def age
    days_old = Date.today - self.dob
    years_old = days_old / 365

    return years_old.to_i
  end
end
```

Now you should be able to do something like this:

```
[23] pry(main)> reload!
Reloading...
=> true
[24] pry(main)> Director.say_hello
"Hello, I'm a class method"
=> "Hello, I'm a class method"
```

Notice that you can't call this method on an individual director:

```
[25] pry(main)> d = Director.first
[26] pry(main)> d.say_hello
NoMethodError: undefined method `say_hello' for #<Director:0x007fba09954ca8>
```

No more than you can call `.age` on the class:

```
[27] pry(main)> Director.age
NoMethodError: undefined method `age' for #<Class:0x007fba07636f28>
```

**RTEM!**

Let's make a more useful class method. Right now, if I know a movie title (e.g. `"The Dark Knight"`) and I want to look up a row in the table, I have to do something like this:

```ruby
t = "The Dark Knight"
m = Movie.where({ :title => t }).first
m.year # => 2008
```

That's not too bad, but what if I wanted to be lazier; whenever I know a movie title and I want to lookup an individual row, I'd like to just say:

```ruby
m = Movie.first_by_title("The Dark Knight")
m.year # => 2008
```

Having a convenience method like that would be great, but right now, I don't:

```
[37] pry(main)> m = Movie.first_by_title("The Dark Knight")
NoMethodError: undefined method `first_by_title' for #<Class:0x007fba0cc20f38>
```

We can _define_ this method for ourselves, though:

```ruby
class Movie < ApplicationRecord
  def Movie.first_by_title(some_title)
    return self.where({ :title => some_title }).first
  end
end
```

Two things to note:

 - When we define a method, we can make it accept arguments using the same syntax that we use to send arguments to a method — parentheses after the method name. We then pick a name for the incoming argument, and we can use it within the method definition (similar in concept to a block variable).
 - We're still using the `self` keyword, which in the context of a _class_ method refers to the class `Movie` itself.

And now we can be lazy! We've _encapsulated_ the lookup logic in a method. `reload!` your console and give it a shot:

```ruby
m = Movie.first_by_title("The Dark Knight")
m.description
```

This saves us a bit of typing. But, more importantly, we're soon going to have much more involved logic that we can encapsulate in methods using this technique, rather than typing it over and over.

## Methods to define

Define the following methods. When you think you've got them working, you can run `rails grade` at a command prompt to check your work.

### Class methods to define

 - `Director.youngest` should return the youngest director on the list. Start by defining a class method with that name:

    ```ruby
    class Director < ApplicationRecord
      def Director.youngest
        return "hello world"
      end
    end
    ```

    And then try calling that method in `rails console` with `Director.youngest` (don't forget to `reload!`). Then progressively enhance the method to return what we're actually looking for. **Work in small steps.** 
 - `Director.eldest` should return the eldest director on the list. Watch out for `nil` values in the `dob` column — `nil` is considered to be "less than" anything else, when ordered.

    You can [use `.not` to filter out](https://chapters.firstdraft.com/chapters/770#wherenotthis) those rows first.
 - `Movie.last_decade` should return all of the rows in the movies table where the year is within the last 10 years.
 - `Movie.short` should return all of the rows in the movies table where the duration is less than 90 minutes.
 - `Movie.long` should return all of the rows in the movies table where the duration is greater than 180 minutes.
 - `Movie.directed_by(2)` should return all of the rows in the movies table that were directed by the director with ID 2.
 - `Character.in_movie(2)` should return all of the rows in the characters table that were in the movie with ID 2.
 - `Character.acted_by(2)` should return all of the rows in the characters table that were played by the actor with ID 2.

### Instance methods to define

 - Given some director, let's call it `d`, `d.filmography` should return the rows in the movies table that belong to the director.

    Remember, our models are accessible from anywhere in the Rails application — `lib/tasks`, `rails console`, and _even from within other models_. So, we can reference `Movie` from inside `Director`:

    ```ruby
    class Director < ApplicationRecord
      def films
        return Movie.where({ :director_id => self.id })
      end
    end
    ```

    or if you've already defined the `Movie.directed_by()` method from above, you could use it here:

    ```ruby
    class Director < ApplicationRecord
      def films
        return Movie.directed_by(self.id)
      end
    end
    ```
 - Given some movie, let's call it `m`,
    - `m.director` should return the row in the directors table whose ID matches the movie's `director_id`.
    - `m.characters` should return all of the rows in the characters table that were in the movie.
 - Given some actor, let's call it `a`, `a.characters` should return all of the rows in the characters table that were played by the actor.

### Stretch goals

 - Given some movie, let's call it `m`, `m.cast` should return a collection of `Actor`s (_not_ `Character`s) that appeared in that movie. Hint: [`.pluck`](https://chapters.firstdraft.com/chapters/770#pluck).
 - Given some actor, let's call it `a`, `a.filmography` should return a collection of `Movie`s that the actor appeared in.
