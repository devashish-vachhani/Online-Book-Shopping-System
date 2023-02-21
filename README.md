# **CSC/ECE 517 - Object Oriented Design and Development**

## **Team Members**
| Name               | Unity ID |
|--------------------|----------- |
| Devashish Vachhani | dvachha |
| Neha Kale          | nkale2 |
| Girish Wangikar    | gwangik |

## **Run the Online Book Shopping System**
- The application is accessible at [VCL deployment](http://152.7.178.109:3000)
- To run the project locally,
  - `git clone https://github.ncsu.edu/dvachha/CSC-ECE-517-Assignment-2-Team-H.git`
  - `cd CSC-ECE-517-Assignment-2-Team-H/app/`
  - `bundle install`
  - `rails db:migrate`
  - `rails server`

## **Log in as admin**
- The pre-configured admin credentials are:
  - username: admin
  - password: admin
- After logging in as admin, you will be directed to the admin dashboard. An admin can:
  - Edit his/her own profile
  - Create/view/edit/delete users
  - Create/view/edit/delete books
  - Create/view/edit/delete reviews
  - Search books by author or average rating above some value
  - Search reviews by username or book name
  - Sign out

## **Sign up/Log in as user**
- A user can sign up themselves. After signing up/logging in as user, you will be directed to the user dashboard. A user can:
  - Edit his/her own profile
  - Delete their own account
  - View the books available on the website
  - Search books by author or average rating above some value
  - Add/remove a book to/from his/her cart
  - Buy a book or books
  - Check their own purchase history
  - Write a review of a book
  - Edit the review he/she wrote
  - Search reviews by username or book name
  - Sign out

## **Validations**
- User
  - username, email and name are always required. password is required while creating a new account
  - phone number should be 10 digits (or blank) and credit card number should be 16 digits (or blank)
- Book
  - name, author, publisher, price and stock are required
- Review
  - rating and review are required
- Transaction
  - address, phone number and credit card number are required

## **Cases we have considered**
- A user should have a unique username and email address
- When a book gets destroyed,
  - it is removed from all shopping carts that contain that book
  - its dependent reviews are destroyed
  - its dependent transactions are nullified
- When a user gets destroyed,
  - its dependent reviews are destroyed
  - its dependent transactions are destroyed
- A user/admin cannot access resources he/she is not allowed to by changing the url
- While creating a new transaction, the form is pre-filled with information from the user's profile
- Race condition is taken care of when multiple users try to buy the same book at the same time

## **RSpec testing**
- The RSpec testing is performed thoroughly for the Book model and the BooksController
- To run the tests,
  - `rake db:migrate RAILS_ENV=test`
  - `bundle exec rspec`