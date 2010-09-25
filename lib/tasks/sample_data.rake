require 'faker'

namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_doctors
  end
end

def make_users
  50.times do |i|
    User.create!(
      :first_name            => Faker::Name.first_name,
      :last_name             => Faker::Name.last_name,
      :email                 => "example-#{i}@example.com",
      :password              => 'password',
      :password_confirmation => 'password'
    )
  end
end

def make_doctors
  50.times do |i|
    Doctor.create!(:name => Faker::Name.name)
  end
end
