namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    
    admin = User.create!(:name => "God!",
                         :email => "thegodfather@gmail.com",
                         :password => "AGodFatherDamn1passowrd",
                         :password_confirmation => "AGodFatherDamn1passowrd")
    admin.toggle!(:admin)
    
    100.times do |n|
      name     = Faker::Name.name
      email    = "example-#{n+1}@railstutorial.org"
      password = "1Verylongpassword"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
