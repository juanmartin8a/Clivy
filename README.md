# Clivy
Social media for gamers!

  - ### Why
    I thought that it would be cool to have a dedicated social media exclusively for gamers since it is a huge community.

  - ### Status
    No longer active as I got sick of working on it. Messy spaguetti code. Well at least I learned to write readable more organized code :)

## Platforms
- iOS
- Android

## Tech used
- Main language used on the backend: TypeScript
- Frontend framework: Flutter
- API: Graphql
- Search engine: Elastic Search
- Main database: PostgreSQL
- Authentication: Self-made secure JWT implementation with token rotation
- Containerization: Docker
- All other cloud: AWS

## Features
- ### Feeds
  Clivy has 2 different feeds:
    - ### For you
      Shows recommended videogame clips based on the user's interactions on the app with a custom made recommendations algorithm written in PostgreSQL.
    - ### Following
      Shows the videogame clips of the users you follow.
- ### Notifications
  You are notified when:
    - A user adds follows you
    - A user likes your videogame clip
    - A user comments on your videogame clip
    - A user replies to your comment
    - A user likes your comment
- ### Likes and Comments
  You can like and comment on any clips and other users can also like and comment on yours! Comments can also be liked and replyed.
- ### Follow system
  A follow system is made to enable building relationships between users, it also helps with better videogame clip recommendations.
- ### Profiles
  Each user has a profile which includes the following information:
  - Name
  - Username
  - Profile picture
  - Followers count
  - Followers list
  - Following count
  - Following list
  - Clips count
  - Your uploaded videogame clips  
- ### User search
  A search engine for looking for people.
