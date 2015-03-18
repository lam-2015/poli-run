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
