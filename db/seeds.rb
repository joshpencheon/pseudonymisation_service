# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Users ##

test_user = User.create!(username: 'test_user')

## PseudonymistionKeys ##

primary_one = PseudonymisationKey.create!(name: 'Primary Key One')
primary_two = PseudonymisationKey.create!(name: 'Primary Key Two')

repseudo_one = PseudonymisationKey.create!(name: 'RePseudo Key One', parent_key: primary_one)
repseudo_two = PseudonymisationKey.create!(name: 'RePseudo Key Two', parent_key: primary_two)
_repseudo_three = PseudonymisationKey.create!(name: 'RePseudo Key Three', parent_key: repseudo_two)

_compound_one = PseudonymisationKey.create!(
  key_type: 'compound',
  name: 'Compound Key One',
  start_key: primary_one,
  end_key: repseudo_one
)

compound_two = PseudonymisationKey.create!(
  key_type: 'compound',
  name: 'Direct access to RePseudo One',
  start_key: repseudo_one,
  end_key: repseudo_one
)

## KeyGrants ##

_grant_one = KeyGrant.create!(user: test_user, pseudonymisation_key: primary_one)
_grant_two = KeyGrant.create!(user: test_user, pseudonymisation_key: compound_two)
