require 'rails_helper'

RSpec.describe Actor, type: :model do
  let(:actor) { build :actor }

  it 'valid' do
    expect(actor).to be_valid
  end

  it 'name is required' do
    actor.name = nil
    expect(actor).not_to be_valid
  end
end
