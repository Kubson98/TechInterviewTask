# QuandooTechTask

## Overview
This project is an iOS App for presenting data of Users and Posts of Selected User from sample REST API. We have two simple screens: 
- List of Users
- Posts of selected User

And also as Extra Tasks I added:
- No data Handling
- Error Handling
- Refresh data
- Unit Tests

## Features
* Fetching informations about Users from JSONPlaceholder API and presenting them on TableView.
* Presenting users data:
  - username
  - name
  - email
  - address (presented in one string)
* Creating a custom UITableViewCell for Users with UIKit
* Fetching informations about Posts of selected User from JSONPlaceholder API and presenting them on List.
* Presenting users data:
    - Title of Post
    - Body of Post
* Creating a custom View for Posts with SwiftUI
* Presenting Error View if there is a problem with fetching data
* Presenting No Data View if the list of users/ list of posts is empty
* Refreshing View (fetching data by pulling down a scroll view)
* Loading Screen (presenting activity indicator during fetching data)
  
## MVVM Components:
* Models: Represent structures of data used in the application:
  - User
  - Post
* Views: 
  - UIKit:
    - Custom UserTableViewCell for UserCells
    - Custom UIView and UIViewController for NoData View and Error View
    - Custom UIViewController for Loading Spinner View
  - SwiftUI:
    - Custom User's Post View with List
    - Custom View for No Data View and Error View
* ViewModels:
  - HomeViewModel:
    - Fetching Users and mapping
    - Updating Fetching State
    - Updating Array of Users
  - UserPostsViewModel:
    - Fetching Posts and mapping
    - Updating Fetching State
    - Updating Array of Posts
   
## Coordinator:
MainCoordinator responsible for navigation

## Networking:
Implementing Services target which User Struct and Post Struct.
Fetching data by URLSession and decode it.

## Testing
Implemented tests for ViewModels (UserPostsViewModel, HomeViewModel) using XCTest framework to cover any case.
