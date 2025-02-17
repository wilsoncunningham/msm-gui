class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def new_movie
    movie = Movie.new
    puts "the new movie is #{movie}"
    puts "making new movie"

    movie.title = params.fetch("query_title")
    movie.year = params.fetch("query_year")
    movie.duration = params.fetch("query_duration")
    movie.description = params.fetch("query_description")
    movie.image = params.fetch("query_image")
    movie.director_id = params.fetch("query_director_id")
    puts "attempting to save movie: #{movie.inspect}"
    puts "Movie ID is: #{movie.id}"

    movie.save

    redirect_to("/movies")
  end

  def delete_movie
    the_id = params.fetch("path_id")
    movie = Movie.find(the_id)

    movie.delete

    redirect_to("/movies")
  end

  def update_movie
    the_id = params.fetch("path_id")
    movie = Movie.find(the_id)

    updated_title = params.fetch("query_title")
    updated_year = params.fetch("query_year")
    updated_duration = params.fetch("query_duration")
    updated_description = params.fetch("query_description")
    updated_image = params.fetch("query_image")
    updated_director_id = params.fetch("query_director_id")

    movie.update(title: updated_title, year: updated_year, description: updated_description, duration: updated_duration, description: updated_description, image: updated_image, director_id: updated_director_id) 

    redirect_to("/movies/#{the_id}")
  end
end
