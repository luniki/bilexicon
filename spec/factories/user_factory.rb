Factory.sequence :login do |n|
  "somebody#{n}"
end

Factory.define :user do |u|
  u.login Factory.next :login
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :editor, :parent => :user do |e|
  e.admin true
end

