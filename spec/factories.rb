# By using the symbol ':user' we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.name                  "Guillermo Guerrero"
  user.email                 "gui.gue@example.org"
  user.password              "foobar"
  user.password_confirmation "foobar"
end
