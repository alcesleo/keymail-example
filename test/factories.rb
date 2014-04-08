# Using Minifacture
# https://github.com/stephencelis/minifacture

Factory.define :user do |f|
  f.email 'user%d@example.com'
end

Factory.define :message do |f|
  f.text 'Testing content...'
  f.user { Factory :user }
end
