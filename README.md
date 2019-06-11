# CatLover

<p align="center">
  <img src="https://github.com/JianTing-Li/CatLover/blob/master/Images/CatLover_Logo.png" />
</p>

Welcome to my first passion app, “CatLover,” an app for people who love cats. My main motivation to make this app is that I am a huge cat fan. I personally own a cat myself 🐱. His name is Mocha. 

# Introduction
Having trouble finding the right cat to adopt? Have you ever wondered what are the different type of cats, cat breeds, and their differences? You can look these answers up on your web browser, but sometimes you need answers quicker. In order to fill this gap I have created CatLover, a simple mobile app. 

# Features

* The user can view a list of cat breeds and find the perfect cat pet using the filter option
* When the user clicks on a cat breed, it would go to a new screen that displays an image of the cat and information about the cat's temperament, intelligence, affectionate level, vocal level, energy level, and a short description of the breed.

![BrowsingCats](https://github.com/JianTing-Li/CatLover/blob/master/Images/BrowsingCats.gif)
<br/><br/>


* If the user is interested in adopting a specific cat, he / she can press the "adopt me" button at the top right corner of the screen. It would bring them to the Petfinder tab showing a list of cats of the selected breed ready to adopt around the user.
* The user can email or make a phone call to inquire information about cats that the user is interested in adopting.

![AdoptingCatBreed](https://github.com/JianTing-Li/CatLover/blob/master/Images/AdoptingCats.gif)
<br/><br/>


* Alternatively, the user can search cats for adoption based on location.

![AdoptCatLocation](https://github.com/JianTing-Li/CatLover/blob/master/Images/AdoptCatLocation.gif)
<br/><br/>


* The user can save potential cats he / she wants to adopt to favorites.

![FavoriteCats](https://github.com/JianTing-Li/CatLover/blob/master/Images/FavoriteCats.gif)
<br/>
 
# Challenges
One of the biggest challenges I encountered while making the app is making multiple network requests to get the data I want. I used one endpoint to get a list of cat breeds sorted alphabetically. However, that endpoint does not contain any images. To solve the problem, I plug the cat ID I got from the first request as a parameter for another endpoint to get images for each cat breed. 

# Future Version
Eventually I want to submit the app to the AppStore. Here are the features I would like to implement before pushing to the app store.
- An option to sign in to an account to save or retrieve their favorites online
- Blogging system for cat lovers to connect with each other 

## Built With
* UIKit
* [Kingfisher](https://github.com/onevcat/Kingfisher)

## Prerequisites
* Xcode - 10.0+, set up on Swift Language
* iOS 8.0+
* Swift 4.0+
* [TheCatAPI Key](https://thecatapi.com/)
* [Petfinder API Key](https://www.petfinder.com/developers/)
