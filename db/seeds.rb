# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Blog.create(:title => 'My first blog', :subtitle => 'For the Bonz test!', :url_identifier => 'main', :is_visible => true, :canonical_domain => 'www.myfirstblog.com')
User.create(:user_name => 'admin', :first_name => 'Admin', :last_name => 'User', :email => 'admin@mysite.com', :password => 'password', :password_confirmation => 'password', :role => User::Role::SUPER_ADMIN)
