namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    puts "Populating the database..."
    admin = User.create!(name: "Luigi De Russis",
                         email: "luigi.derussis@polito.it",
                         password: "lam-2015",
                         password_confirmation: "lam-2015")
    admin.toggle!(:admin)
    puts "... the admin user has been created"
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@corsa.polito.it"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    puts "... 99 users have been created"
  end
end