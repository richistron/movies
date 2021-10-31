require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { create :movie }

  it 'title required' do
    movie.title = nil
    expect(movie).not_to be_valid
    expect(movie.errors).to include(:title)
  end

  it 'description required' do
    movie.description = nil
    expect(movie).not_to be_valid
    expect(movie.errors).to include(:description)
  end

  it 'director required' do
    movie.director = nil
    expect(movie).not_to be_valid
    expect(movie.errors).to include(:director)
  end

  it 'valid' do
    expect(movie).to be_valid
  end

  describe 'actors' do
    let(:actor) { create :actor }
    let(:cast) { create :cast }

    it 'actors through casts' do
      expect(movie.save).to be_truthy
      cast.actor = actor
      cast.movie = movie
      cast.save
      movie.reload
      expect(movie.actors.first.name).to eq('Michael Keaton')
    end
  end
end
