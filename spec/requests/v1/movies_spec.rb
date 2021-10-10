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

  describe 'create' do
    let(:director) { create :director }

    it '201' do
      post '/v1/movies', params: {
        title: 'Edward Scissorhands',
        description: 'An artificial man, who was incompletely constructed and has scissors for hands, leads a solitary life. Then one day, a suburban lady meets him and introduces him to her world.',
        director_id: director.id
      }
      expect(response).to have_http_status(201)
    end

    it '400' do
      post '/v1/movies'
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body)
      expect(body['director'].first).to match('must exist')
      expect(body['description'].first).to match("can't be blank")
      expect(body['title'].first).to match("can't be blank")
    end
  end

  describe 'update' do
    let(:movie) { Movie.last }

    it '200' do
      patch "/v1/movies/#{movie.id}", params: {
        title: 'Edward Scissorhands 2',
        description: 'Foo bar',
      }
      expect(response).to have_http_status(200)
    end

    it '400' do
      patch "/v1/movies/#{movie.id}", params: {
        title: nil,
        description: nil,
        director_id: nil
      }
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body)
      expect(body['director'].first).to match('must exist')
      expect(body['description'].first).to match("can't be blank")
      expect(body['title'].first).to match("can't be blank")
    end
  end
end
