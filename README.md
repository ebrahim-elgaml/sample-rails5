
# sample-rails5


Things you may want to cover:

* Ruby version: 2.3.3

* Rails version: 5.0.1

* Database: Mongoid

* Run test: bundle exec rspec

* Api only so no view.

* Mini description : user can add list of skills with a level for each skill and users can search for each other by skill.

=======

### Sample requests:

Description | Request | Body | Method
--- | --- | --- | ---
user register | http://localhost:3000/users | `{ "user": {"email": "a@test.com", "password": "123456789", "first_name": "fname", last_name: "lname"} }` | **post**
user login | http://localhost:3000/users/login | `{ "user": {"email": "a@test.com", "password": "123456789"} }`| **post**


