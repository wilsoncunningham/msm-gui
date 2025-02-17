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

    movie.title = params.fetch("query_title")
    movie.year = params.fetch("query_year")
    movie.duration = params.fetch("query_duration")
    movie.description = params.fetch("query_description")
    movie.image = params.fetch("query_image")
    movie.director_id = params.fetch("query_director_id")

    movie.save

    redirect_to("/movies")
  end

  def delete_movie
    the_id = params.fetch("path_id")
    movie = Movie.find(the_id)

    movie.delete

    redirect_to("/movies")
  end

  # def update_actor
  #   the_id = params.fetch("path_id")
  #   actor = Actor.find(the_id)

  #   updated_name = params.fetch("query_name")
  #   updated_dob = params.fetch("query_dob")
  #   updated_bio = params.fetch("query_bio")
  #   updated_image = params.fetch("query_image")

  #   actor.update(name: updated_name, dob: updated_dob, bio: updated_bio,
  #                   image: updated_image)

  #   redirect_to("/actors/#{the_id}")
  # end
end
