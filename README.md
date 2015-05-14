## PoliRun ##

PoliRun is a prototype social network realized for the "Linguaggi e Ambienti Multimediali" course at Politecnico di Torino (academic year 2014/2015). It is inspired by the [Ruby on Rails Tutorial](http://rails-3-2.railstutorial.org/) book by Michael Hartl.

### Pages, helper and routes (LAB 2) ###

1) Creation of static pages for our social network: home, about and contact

- `rails generate controller Pages home about contact` (or from the RubyMine menu *Tools > Run Rails Generator...*)

2) In the home view, add a link to the other two views, e.g., `<%= link_to "About", "#" %>`

3) Add a title to the HTML files: "PoliRun | Page name"

- by using the `provide` method in each view, i.e., `<% provide :title, "Page name" %>`
- by editing the title tag in `app/views/layouts/application.html.erb`, i.e., `<title>PoliRun | <%= yield(:title) %></title>`
- learn more about `provide` at [http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-provide](http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-provide)

4) Add an helper named `full_title`, to avoid wrong rendering if a page title is not declared

- in `app/helpers/application_helper.rb`, since it can be useful for every views in the site
- by editing the title tag in `app/views/layouts/application.html.erb`, i.e., `<title><%= full_title(yield(:title)) %></title>`

5) Update the `routes.rb` file according to the table reported in Exercise 4

- in the `config` folder
- update the links in the home accordingly
- remove `index.html` from the public folder

6) Add a faq page to the Pages controller and set a proper route

### Applying some styles... (pre LAB 3) ###

1) Fill all the views with some contents

2) Add `bootstrap-sass` gem (version 3.1.1.0) to include the Bootstrap framework with Sass support [http://getbootstrap.com/](http://getbootstrap.com/)

- update the `Gemfile`
- run `bundle install`

3) Add and fill a custom SCSS file in `app/assets/stylesheets`

### User Modeling (LAB 3) ###

1) Move HTML shim, header and footer code in three partials (placed in `app/views/layouts/`)

2) Generate the User model, with two attributes: name and email

- `rails generate model User name:string email:string` (or from the RubyMine menu *Tools > Run Rails Generator...*)

3) Migrate the model to the database (i.e., create the table and columns corresponding to the User model)

- `bundle exec rake db:migrate` (or from the RubyMine menu *Tools > Run Rake Tasks...*)

4) Add some gems to the Gemfile (and perform a `bundle install`)

- `annotate` (version 2.5.0) to show some annotations in the Rails models
- `bcrypt-ruby` (already present, but commented) to have some state-of-the-art hash functions available in Rails

5) Annotate the User model to show a little bit more information

- `bundle exec annotate` (or add a new configuration of type *Gem Command* from the RubyMine menu *Run > Edit Configurations...*)

6) Add debug information in `application.html.erb`, by using the `debug` method

- edit the custom stylesheet to improve the rendering of the debug box

7) Add some validations to the User model

- `name` must be always present (`presence: true`) and it must have a maximum length of 50 characters (`length: { maximum: 50 }`)
- `email` must be always present, unique (`uniqueness: { case_sensitive: false }`) and with a specific defined format (`format: { with: VALID_EMAIL_REGEX }`)

8) Enforce the uniqueness of the email by generating a new migration

- add an index on the `email` column in the `users` database
- execute the migration

9) Give to the User model a `password` field

- generate/migrate a migration to add a column to store the password digest (i.e., an encrypted version of the password)
- add the `has_secure_password` method to the User model, to use the authentication system of Rails
- make accessible the two virtual attributes added by `has_secure_password`: `password` and `password_confirmation`
- add a minimum length validation (8 chars) to the `password` attribute

### Getting started with the User controller... (pre LAB 4) ###

1) Create a Users controller for the signup page

- `rails generate controller Users new` (or from the RubyMine menu *Tools > Run Rails Generator...*)

2) Update the `routes.rb` file for mapping the `new` action to `/signup` (i.e., create a named route)

3) Add some contents to the newly created view and update the homepage link for registering new users

4) Add the default routes for the Users controller

- `resources :users` in `config/routes.rb`

5) Add a user in the database, by editing the `new` action in the Users controller

6) Add a new view associated to the Users controller

- create `show.html.erb` in `app/views/users` (filled with some contents)
- update the page stylesheet
- add the corresponding action to the User controller (`users_controller.rb`)

7) Add an (almost complete) helper for using a Gravatar as the profile pic for users (in `users_helper.rb`)

### Sign Up (LAB 4) ###

1) Complete the Gravatar helper

2) Remove the existing (temporary) user

- in the database: `bundle exec rake db:reset` (or from the RubyMine menu *Tools > Run Rake Tasks...*)
- in the code: delete the line in the `new` action of the Users controller

3) Add the sign up form in the `new.html.erb` view and update the corresponding action

- by using the `form_for` helper method, which takes in an Active Record object and constructs a form using the object's attributes
- by adding `@user = User.new` to the `new` action of the Users controller

4) Update the stylesheet for a better rendering of the form

5) Add the `create` action to the Users controller (it is needed for the sign up form)

- create a new user with the information inserted in the form
- if it is possible to save such a user into the database, go to the user profile page
- otherwise, go back to the sign up form

6) Update the sign up form to show error messages (if any)

- add a `_error_messages.html.erb` partial (in `app/views/shared`) to store the code for showing error messages of a generic form

7) Add the flash to welcome newly registered users to our site

- insert an area to show the flash message in `application.html.erb`
- fill the flash if the user signup has been successful (i.e., in the Users controller)

### Handling Users (LAB 5) ###

1) Create a SessionHelper and include it in the `ApplicationController` (helpers are automatically added to views, but not to controllers)

- create `sessions_helper.rb` in `app/helpers`
- add `include SessionsHelper` in `app/controllers/application_controller.rb`
- define a method named `handle_unverified_request` to prevent cross-site request forgery attacks in `application_controller.rb`

2) Add a migration to associate a user to its remember token (to be added in the traditional Rails session)

- generate/migrate a migration to add a column and a index for the remember token in the users table

3) Update the User model to handle the remember token

- add a callback method to create the remember token (`before_save :create_remember_token`); in this way, Rails will look for
a `create_remember_token` method and will run it before saving the user
- define such a method as private and generate the token by using the `SecureRandom.urlsafe_base64` function; the method generates
a random string, safe for use in URIs, of length 16

4) Add various methods to the SessionsHelper

- `sign_in`: store the remember token in a permanent cookie (it lasts for 20 years...) and set the user performing the sign in as the current user
- two methods to set and get the current (logged) user for passing this information to all the other pages
- `is_signed_in?`: tell if the current user is signed in
- `sign_out`: clear the current user instance variable and delete the corresponding cookie, thus signing out the user

5) Call the `sign_out` method in the ApplicationController (`handle_unverified_request` method)

6) Generate a Sessions controller and a `new.html.erb` view

- `rails generate controller Sessions new` (or from the RubyMine menu *Tools > Run Rails Generator...*)

7) Update routes to implement the session as a RESTful resource

- add `match '/signin', to: 'sessions#new'` and `match '/signout, to: 'sessions#destroy', via: :delete`
- add `resources :sessions, only: [:new, :create, :destroy]`

8) Fill the Sessions controller with the required (empty) actions (new, create and destroy)

9) Fill the view for the signin form (i.e., `app/views/sessions/new.html.erb`)

- we need to ask for email (the username in our social network) and password
- since a session is not a Model, define the form as `form_for(:session, url:session_path)`, where the former element is the resource name and the latter is the corresponding URL
- submit the form will result in `params[:session][:email]` and `params[:session][:password]`, to be used in the `create` action

10) Write the `create` action in the Sessions controller

- get the registered user starting from the email given in the sign in form (`params[:session][:email]`)
- check if the user exists and if the given password is correct (`if user && user.authenticate(params[:session][:password])`)
- handle a successful login (call the `sign_in` method declared in the `SessionsHelper`)
- handle a failed login (show an error message and go back to the login form)

11) Update the header navbar

12) Update the sign up method (i.e., the `create` action in the Users controller) to perform a login if the registration was successful

13) Write the `destroy` action in the Sessions controller for signing out

- call the `sign out` method of SessionsHelper
- redirect to the homepage

14) Create the `edit` action and view for the Users controller

- please note that the `edit` view is almost identical to the `new` view
- let the user change her Gravatar, too

15) Update the Settings link in the header

- it should point to `edit_user_path(current_user)`

16) Define the `update` action in the Users controller

- it is the action called after the edit form submission
- get the updated user information from the edit form (`params[:user]`)
- check if the update was successful and handle success and fail cases

17) Right now, everyone can edit user information, so we should implement some controls

- add a filter to the Users controller: before performing the edit and update actions, check if the user is signed in (`before_filter :signed_in_user, only: [:edit, :update]`)
- add a filter to the Users controller: before performing the edit and update actions , check if the current user is the "right" user (`before_filter :correct_user, only: [:edit, :update]`)
- add the two (private) methods declared in the before filters in the Users controller (i.e., `signed_in_user` and `correct_user`)
- add another helper method to the SessionsHelper, : check if the user for which the editing actions are called is also the current user
- update the `edit` and `update` actions to remove a useless `@user` assignment