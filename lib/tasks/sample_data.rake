namespace :db do
  desc "Fill database with sample user data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_relationships
  end
end

def make_users
  400.times do |n|
    name = Faker::Name.name
    User.create!(:name => name)
  end
end

def make_relationships
  users = User.all
  (1..200).each do |i|
    user  = users[i]
    following = users[(i+1)..(i+100)]
    followers = users[(i+3)..(i+90)]
    following.each { |followed| user.follow!(followed) }
    followers.each { |follower| follower.follow!(user) }
  end
end
