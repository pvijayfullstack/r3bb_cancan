# require 'ffaker'

namespace :db do
  desc "Fill database with sample data"
  task :put => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_posts
  end
end

def make_users
    admin = User.create!(:email => "admin333@example.com",
                         :password => "admin333",
                         :password_confirmation => "admin333",
                         :roles => ["admin"])
    
    user = User.create!(:email => "user333@example.com",
                         :password => "user333",
                         :password_confirmation => "user333",
                         :roles => ["user"])
end

def make_posts
    post1 = Post.create!(:name => "BigTester1",
                         :title => "This is a test1",
                         :content => "There are lots of tests1")
   post2 = Post.create!(:name => "BigTester2",
                         :title => "This is a test2",
                         :content => "There are lots of tests2")
   post3 = Post.create!(:name => "BigTester3",
                         :title => "This is a test",
                         :content => "There are lots of tests3")                                                                                                        
 end
 