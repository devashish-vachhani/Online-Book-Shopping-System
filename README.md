# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Flow

### The Landing Page
1. First the landing page opens. Here you can either sign up as a user or login in as an admin or user.
2. - Sign up: This is the user sign up page. After filling in the required fields (Beware! There are validations in place), the user is taken to the user dashboard.
- - Log in as user: This is the user log in page. After entering the username and password, the user is taken to the user dashboard.
- - Log in as admin: This is the admin log in page. After entering the username and password, the user is taken to the admin dashboard.

### The User Dashboard

- This page has a navigation bar. The user can return to the dashboard, edit profile, view the cart or sign out using the navbar. The username can also be seen here.
- The user can view, search, buy or review books using the first link.
- The user can view purchase history using the second link.
- The user can view their reviews using the third link.
- The user can view and search other users' review using the fourth link.

### The Admin Dashboard

- This page has a navigation bar. The admin can return to the dashboard, edit profile or sign out using the navbar. The admin username can also be seen here.
- The admin can create, edit or delete users using the first link.
- The admin can create, edit or delete books using the second link.
- The user can create, edit or delete reviews using the third link.

### create/edit/delete user
In create/edit/delete user you can edit the existing users by changing all the attributes of a user and update existing user, you can create a new user by entering information in required fields adhering to given restrictions or you can also entirely delete an account of existing user. If a user is deleted all the reviews of that user are also deleted.

### create/edit/delete book
Under Admin profile you can create new book, where by entering book name, author, publisher, price and stock new entry of a book is created. You can also show, edit and delete an existing entry of a book. Show allows to take a look at all the users and their reviews for that particular book. You can also Search a book by its Author name and Rating. Search by rating displays the all the books above certain average rating. If a book is deleted all the reviews associated with that book are also deleted.

### create/edit/delete review
Admins also have access to create/delete/edit reviews. We can search a review by book or username.

