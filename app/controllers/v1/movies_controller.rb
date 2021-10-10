class V1::MoviesController < ApplicationController
  before_action :find_movie, only: [:show]

  def index
    render json: json_response(Movie.all)
  end

  def show
    render json: json_response(@movie)
  end

  private

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
