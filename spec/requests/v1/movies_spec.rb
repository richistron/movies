require 'rails_helper'

RSpec.describe "V1::Movies", type: :request do
  before do
    director = create :director
    movie = create :movie, director: director
    actor = create :actor
    create :cast, movie: movie, actor: actor
  end

  it 'get index' do
    get '/v1/movies'
    expect(response).to have_http_status(200)
    body = JSON.parse(response.body)
    first_movie = body.first
    expect(first_movie['title']).to eq('Batman (1989)')
    expect(first_movie['description']).to match('The Dark Knight of Gotham City')
    director = first_movie['director']
    expect(director['name']).to eq('Tim Burton')
    actor = first_movie['actors'].first
    expect(actor['name']).to eq('Michael Keaton')
  end

  describe 'show' do
    let(:movie) { Movie.first }

    it '200' do
      get "/v1/movies/#{movie.id}"
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['title']).to eq('Batman (1989)')
      expect(body['description']).to match('The Dark Knight of Gotham City')
      director = body['director']
      expect(director['name']).to eq('Tim Burton')
      actor = body['actors'].first
      expect(actor['name']).to eq('Michael Keaton')
    end

    it '404' do
      get '/v1/movies/999999'
      expect(response).to have_http_status(404)
    end
  end
end
