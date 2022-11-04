# README

<img width="750" alt="teatimeDB" src="https://user-images.githubusercontent.com/100792434/199850572-0dd382ab-64d4-4687-a898-75486f425e34.png">

Designed and implemented by Eli Sachs

## TEATIME

Teatime is a Rails API backend for a Tea Subscription service with an object-relational Postgres database linking customers and teas in a many-to-many relationship through their subscriptions.

## DATABASE

Teas
* title
* description
* temperature
* brew_time

Customers
* first_name
* last_name
* email
* address

Subscriptions
* title
* price
* status
* frequency
* tea_id
* customer_id

## ENDPOINTS

Five total RESTful API endpoints, two of which (create customer and create subscription) require a JSON body.

* creating customers

  `POST /api/v1/customers`

  JSON body example (all params required): 
  ```
  { "first_name": "eli", "last_name": "sachs", "email": "es@g", "address": "1001 Dexter" }
  ```

* subscribing a customer to a tea subscription

  `POST /api/v1/subscriptions`

  JSON body example (all params required):
  ```
  { "title": "bundle", "price": 5.50, "frequency": "weekly", "tea_id": 1, "customer_id": 1 }
  ```

* cancelling a tea subscription

  `PATCH /api/v1/subscriptions/:id`

  Changes subscription status from 'active' to 'cancelled'

* accessing all of a customer's subscriptions (both active and cancelled)

  `GET /api/v1/customers/:id`

* listing all teas

  `GET /api/v1/teas`


## SET UP

To set up TEATIME locally, fork if desired and then clone this (or that) repo. Ater changing into the head of the directory, run `bundle install`, then `rails db:{drop,create,migrate,seed}`, and finally `rails server` to run this app locally (most likely on `http://localhost:3000/`) with a tool like Postman.

## TESTING

TEATIME has 100% testing coverage through RSpec and SimpleCov. Testing ocurred at the model, serializer, and feature/request level. To run the RSpec test suite, run `bundle exec rspec` after following the set up instructions.