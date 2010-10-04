
Factory.define :role do |user_role|
  user_role.name "User"
end

Factory.define :user do |user|
  user.email                  "mail4@recursive-design.com"
  user.password               "123456"
  user.password_confirmation  "123456"
end
