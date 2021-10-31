FactoryBot.define do
  factory :movie do
    title { 'Batman (1989)' }
    description { 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.' }
    director { create :director }
  end
end
