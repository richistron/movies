FactoryBot.define do
  factory :cast do
    movie { create :movie }
    actor { create :actor }
  end
end
