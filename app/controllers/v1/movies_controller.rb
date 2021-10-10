class V1::MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :update]

  def index
    render json: json_response(Movie.all)
  end

  def show
    render json: json_response(@movie)
  end

  def create
    movie = Movie.new movie_params
    if movie.save
      render status: 201, json: json_response(movie)
    else
      render status: 400, json: movie.errors
    end
  end

  def update
    if @movie.update movie_params
      render status: 200, json: json_response(@movie)
    else
      render status: 400, json: @movie.errors
    end
  end

  private

  def movie_params
    params.permit(:title, :description, :director_id)
  end

  def find_movie
    @movie = Movie.find params[:id]
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  def json_response(scope)
    scope.as_json(
      include: [
        { director: { only: [:name, :id] } },
        { actors: { only: [:name, :id] } }
      ],
      except: [:director_id, :created_at, :updated_at]
    )
  end
end
