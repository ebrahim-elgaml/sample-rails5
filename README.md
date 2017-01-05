
# sample-rails5


* Ruby version: 2.3.3

* Rails version: 5.0.1

* Database: Mongoid

* Run specs: bundle exec rspec

* Api only so no views.

* Mini description : user can add list of skills with a level for each skill and users can search for each other by skill.

=======

### Sample requests:

* For requests which need authorization set headers to `{ Authorization: user_api_key }`

Description | Request | Body | Method
--- | --- | --- | ---
user register | /users | `{ "user": {"email": "a@test.com", "password": "123456789", "first_name": "fname", "last_name": "lname"} }` | **POST**
user login | /users/login | `{ "user": {"email": "a@test.com", "password": "123456789"} }`| **POST**
signout | /users/signout |  | **GET**
add skill | /user_skills | `{ "user_skill": {"skill_id": "music", "level": 3} }` | **POST**
search users | /user_skills | `?q=muisc` | **GET**
