namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Foo Bar",
                 email: "foo@bar.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.projects.create!(name: content) }
    end
    projects = admin.projects.all(limit: 6)
    50.times do
      content = 1 + rand(6)
      projects.each { |log| project.logs.create!(float_entry: content, log_date: Date.current) }
    end
  end
end
