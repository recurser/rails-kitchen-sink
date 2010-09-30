
admin_role = Role.create({:name => 'Admin' })
user_role  = Role.create({:name => 'User' })

admin = User.create({
  :email => 'admin@recursive-design.com',
  :password => '123456',
  :password_confirmation => '123456',
  :confirmed_at => Time.now
})

admin.roles << admin_role
admin.roles << user_role

user = User.create({
  :email => 'user@recursive-design.com',
  :password => '123456',
  :password_confirmation => '123456',
  :confirmed_at => Time.now
})

user.roles << user_role