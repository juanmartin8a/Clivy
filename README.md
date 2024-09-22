# Clivy
Social media for gamers!

  - ## Why
    I thought that it would be cool to have a dedicated social media exclusively for gamers since it is a huge community.

  - ## Status
    No longer active as I got sick of working on it. Messy spaguetti code. Well, at least I learned to write readable more organized code :)

## Platforms
- iOS
- Android

## Tech used
- **Main language used on the backend**: TypeScript
- **Frontend framework**: Flutter
- **API**: Graphql
- **Search engine**: Elastic Search
- **Main database**: PostgreSQL
- **Authentication**: Self-made secure JWT implementation with token rotation
- **Containerization**: Docker
- **All other cloud**: AWS

## Features
- ### Feeds
  Clivy has 2 different feeds:
  
    - **For you**: Shows recommended videogame clips based on the user's interactions on the app with a tailored-made recommendations algorithm written in PostgreSQL.
  
    - **Following**: Shows the videogame clips of the users you follow.
- ### Notifications
  You are notified when:
    - A user adds follows you
    - A user likes your videogame clip
    - A user comments on your videogame clip
    - A user replies to your comment
    - A user likes your comment
    - A user tags you in a comment, reply, or clip caption
- ### Likes and comments
  You can like and comment on any clips and other users can also like and comment on yours! Comments can also be liked and replied.
- ### Follow system
  A follow system is made to enable building relationships between users, it also helps with better videogame clip recommendations.
- ### Tagging system
  A tag system allows users to directly mention others by linking to their user profiles. This is done by using the "@" symbol followed by the username of the user being tagged, for example: "@juanmartin8a". When a user taps on this tag, the app navigates to the tagged user's profile.
- ## Clip information
  The information that can be found on an uploaded clip includes:
    - Video
    - Caption
    - Date and time of creation
    - User that created the clip
    - Like count
    - Like list
    - Comment count
    - Comment list
- ### Profiles
  Each user has a profile which includes the following information:
  - Name
  - Username
  - Profile picture
  - Follower count
  - Follower list
  - Following count
  - Following list
  - Clips count
  - Uploaded videogame clips  
- ### User search
  A search engine for looking for people.
