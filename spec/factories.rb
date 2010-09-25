Factory.define :user do |user|
  user.first_name            'Foo'
  user.last_name             'Bar'
  user.email                 'foobar@example.com'
  user.password              'foobar'
  user.password_confirmation 'foobar'
end

Factory.define :doctor do |doctor|
  doctor.name 'Feel Good'
end
