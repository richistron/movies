require 'rails_helper'

RSpec.describe "V1::Movies", type: :request do
  before do
    director = create :director
    movie = create :movie, director: director
    actor = create :actor
    create :cast, movie: movie, actor: actor
  end

  describe "GET /index" do
    it 'smoke test' do
      get '/v1/movies'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Batman (1989)')
      body = JSON.parse(response.body)
      first_movie = body.first
      expect(first_movie['title']).to eq('Batman (1989)')
      expect(first_movie['description']).to match('The Dark Knight of Gotham City')
      director = first_movie['director']
      expect(director['name']).to eq('Tim Burton')
      actor = first_movie['actors'].first
      expect(actor['name']).to eq('Michael Keaton')
    end
  end
end
