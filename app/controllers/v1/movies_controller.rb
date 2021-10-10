class V1::MoviesController < ApplicationController
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :find_movie, only: [:show, :update, :destroy]
  # before_action :authenticate, except: [:index, :show]

  def index
    render json: json_response(Movie.all), status: :ok
  end

  def show
    render json: json_response(@movie), status: :ok
  end

  def create
    movie = Movie.new movie_params
    if movie.save
      render status: :created, json: json_response(movie)
    else
      render status: :bad_request, json: movie.errors
    end
  end

  def update
    if @movie.update movie_params
      render status: :ok, json: json_response(@movie)
    else
      render status: :bad_request, json: @movie.errors
    end
  end

  def destroy
    @movie.casts.each { |cast| cast.destroy }
    @movie.destroy
    render status: :no_content
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

  # def authenticate
  #   authenticate_or_request_with_http_token do |token|
  #     token == '123'
  #   end
  # end
end
