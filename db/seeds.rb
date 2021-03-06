# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'
require 'minifacture'
require_relative '../test/factories'

users = 10.times.map { Factory :user, email: Faker::Internet.email }
100.times.map { Factory :message, user: users.sample, text: Faker::Lorem.sentence }
