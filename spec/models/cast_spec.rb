require 'rails_helper'

RSpec.describe Cast, type: :model do
  let(:cast) { build :cast }

  it 'valid' do
    expect(cast).to be_valid
  end

  it 'movie is required' do
    cast.movie = nil
    expect(cast).not_to be_valid
  end

  it 'actor is required' do
    cast.actor = nil
    expect(cast).not_to be_valid
  end
end
