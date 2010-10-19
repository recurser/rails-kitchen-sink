
Factory.define :role do |user_role|
  user_role.name "User"
end

Factory.define :user do |user|
  user.email                  "railskitchensink@recursive-design.com"
  user.password               "123456"
  user.password_confirmation  "123456"
end

Factory.define :contact do |contact|
  contact.email   "railskitchensink@recursive-design.com"
  contact.subject "Urgent Problem"
  contact.body    "Please reply ASAP!"
end

Factory.sequence :email do |n|
  "test+#{n}@recursive-design.com"
end