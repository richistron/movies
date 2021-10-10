class V1::MoviesController < ApplicationController
  def index
    render json: json_response(Movie.all)
  end

  private

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
