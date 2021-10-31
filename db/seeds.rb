# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

director = Director.create! name: 'Tim burton'
movie = Movie.create! title: 'Batman (1989)',
                      description: 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.',
                      director: director
actor = Actor.create! name: 'Michael Keaton'
Cast.create! movie: movie, actor: actor
