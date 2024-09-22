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
  
  The clips coming from each feed can be filtered by videogame. This means that you can choose to view clips from a specific videogame in the "For you" or "Following" feeds.
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

## Pictures
<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/aba6de07-dd4a-4e4d-b958-ea8389fa8d5f" alt="Screenshot 0" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/6337de9d-1487-4b44-8cb7-7fccdaa1066a" alt="Screenshot 1" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/e632fbdc-bf33-4cfb-b905-d932185e65a6" alt="Screenshot 2" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/e958fa3c-e48e-49b5-a9b7-50d406cb97b0" alt="Screenshot 3" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/4e73f232-6fcc-4491-a155-8fb2b9f50ec0" alt="Screenshot 4" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  <img src="https://github.com/user-attachments/assets/5a58dc31-1825-4953-8450-225ae2955e35" alt="Screenshot 5" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
</div>

## Disclaimer
There are a few things to note about this project:
  - I only have pictures from when the app was in development.
  - At first, I tested the app by uploading any video instead of videogame clips.
  - Often, I would use hard-coded data instead of the uploaded data in order to quickly test how the text data would look with different amounts of characters
  - The last picture is the closest to how the app looked like.
