# By using the symbol ':user' we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.name                  "Guillermo Guerrero"
  user.email                 "gui.gue@example.org"
  user.password              "1Verylongpassword"
  user.password_confirmation "1Verylongpassword"
end

Factory.sequence :email do |n|
  "user-#{n}@example.org"
end
