# Movies

This is a simple rails api, the goal of this project is to learn a little bit
about how rails works and how to do:

* Migrations
* Models
* Controllers
* Scopes
* Unit tests
* And more

# Schema

---
Movie
---
id: number

title: string

description: text

director_id: number

---
Director
---
id: number

name: string

---
Actor
---
id: number

name: string

---
Cast
---
id: number

movie_id: number

actor_id: number
