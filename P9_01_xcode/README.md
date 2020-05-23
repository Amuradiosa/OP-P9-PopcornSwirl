#  OpenClassrooms - iOS development path - iOS Project 9
## PopCornSwirl - Portrait (iPhones and iPads)
## Core Data - Networking - GoogleMobileAds - MVC
## App Structure:
### 1- MoviesListViewController:
- Gets the latest movies (by default) available to watch, offers the ability to select a particular release year and then it reloads all movies released in that year.<br/>
- It consists of a collection view and dropdown menu which in turn consists of a UITextField and a PickerView.<br/>
- User can tap on any movie to see extended movie details, then the user will be able to add it to favourite or watched lists.<br/>
### 2- BookMarkedMovies and WatchedMovies ViewControllers:
- Shows the saved user personal lists of favourite and watched movies using NSFetchedResultsController.<br/>
- It consists of a collection view.<br/>
- Again user can tap on any movie to see extended movie details.<br/>
### 3- MovieDetailViewController:
- Shows the extended details of a  tapped movie with an ad banner displayed at the bottom  to market various products to movie lovers.<br/>
- It consists of various subviews to show movie details(Genre, Release date, long description....), and four buttons to mark and add movies to personal lists, attach a personal note to a watched movie and a More on iTunes button to redirect the user to the purchasing resource if anything gets their attention.<br/><br/>


This application uses ["iTunes as Movies data base"](https://itunes.apple.com/) <br/>


<p align="center">
<img src="P9_01_xcode/images/1.png" width="300">
</p><br/>


# App User Flow
## Launch Screen

<p align="center">
<img src="P9_01_xcode/images/2.png" width="300">
</p><br/>

## Initial Screens
The user first sees the latest movies in the current year.<br/> 

<p align="center">
<img src="P9_01_xcode/images/3.png" width="300">
<img src="P9_01_xcode/images/4.png" width="300">
</p><br/>

Then the user can select a particular year from the dropdown menu on the top to see movies that were released in that year.<br/>

<p align="center">
<img src="P9_01_xcode/images/5.png" width="300">
</p><br/>

The user can tap on any movie to see the movie's extended details with an ad banner displayed at the bottom, the user has the option to add it to a personal favourite list of movies to watch  by tapping on the "Bookmark" button.<br/>

<p align="center">
<img src="P9_01_xcode/images/6.png" width="300">
<img src="P9_01_xcode/images/7.png" width="300">
</p><br/>

The user has the option to mark a movie as watched by tapping on the "AddToWatched" button and it will be added to watched list, then the user can attach a note to it if desired.<br/> 

<p align="center">
<img src="P9_01_xcode/images/8.png" width="300">
<img src="P9_01_xcode/images/9.png" width="300">
<img src="P9_01_xcode/images/10.png" width="300">
</p><br/>

The user can view the note and edit it at any time.<br/>

<p align="center">
<img src="P9_01_xcode/images/11.png" width="300">
<img src="P9_01_xcode/images/12.png" width="300">
</p><br/>

## Favourite and Watched lists
The user can tap on any movie again to see the movie extended details, the user can unmark the movie and/or move it to a different list by tapping on "Bookmark" / "AddToWatched" buttons. <br/> 


<p align="center">
<img src="P9_01_xcode/images/13.png" width="300">
<img src="P9_01_xcode/images/14.png" width="300">
</p><br/>



