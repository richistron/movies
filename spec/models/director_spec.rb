require 'rails_helper'

RSpec.describe Director, type: :model do
  let(:director) { build :director }

  it 'name is required' do
    director.name = nil
    expect(director).to_not be_valid
  end

  it 'valid' do
    expect(director).to be_valid
  end
end
