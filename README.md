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