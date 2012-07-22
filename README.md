# herder

[![Build Status](https://secure.travis-ci.org/geeksoflondon/herder.png?branch=master)](http://travis-ci.org/geeksoflondon/herder)

The herder that allows all animals to talk to the hamster

## Installation

Add to Gemfile for a Rails app:

```ruby
gem "herder"
```

Bundle and then add a `config/herder.yml`

```yml
site: http://localhost:3000/
user: "username"
password: "password"
```

Or don't add the yml file to fall back on the ENV variables `HERDER_SITE`, `HERDER_USER` and `HERDER_PASSWORD`. This is useful for Heroku.

## Basic usage

For now Herder adds a few built in ActiveResource classes.

* `Herder::Attendee`
  * has many `Herder::Emails`
  * has many `Herder::Tickets`
* `Herder::Email`
  * belongs to `Herder::Attendee`
* `Herder::Ticket`
  * belongs to `Herder::Attendee`
  * belongs to `Herder::Event`
* `Herder::Event`
  * has many `Herder::Tickets`
  * belongs to `Herder::Venue`
* `Herder::Venue`
  * has many `Herder::Events`

For full usage details read the [ActiveResource documentation](http://api.rubyonrails.org/classes/ActiveResource/Base.html).

```ruby
Herder::Attendee.find(1)
#=> #<Attendee:0x007f9aabb84550 @attributes={"created_at"=>"2012-07-10T19:26:23Z", "diet"=>nil, "first_name"=>"John", "id"=>1, "kind"=>1, "last_name"=>"Doe", "name"=>"John Doe", "notes"=>nil, "phone_number"=>nil, "public"=>true, "tshirt"=>nil, "twitter"=>nil, "updated_at"=>"2012-07-10T19:26:23Z"}, @prefix_options={}, @persisted=true>
```

Alternatively you can make your own models to extend the base classes:

```ruby
# in app/models/attendee.yml

class Attendee < Herder::Attendee
  # add your own convenience methods here
end

# anywhere else
Attendee.find(1)
#=> #<Attendee:0x007f9aabb84550 @attributes={"created_at"=>"2012-07-10T19:26:23Z", "diet"=>nil, "first_name"=>"John", "id"=>1, "kind"=>1, "last_name"=>"Doe", "name"=>"John Doe", "notes"=>nil, "phone_number"=>nil, "public"=>true, "tshirt"=>nil, "twitter"=>nil, "updated_at"=>"2012-07-10T19:26:23Z"}, @prefix_options={}, @persisted=true>
```

## Using interactions

Interactions are a handy key-value attributes that can be set on other classes (Interactables). This is handy as it means we don't need to add loads of extra booleans to Hamster for every little thing we might need to keep track of.

**Note:** Interactions are never deleted, hence you can always get a full log of interactions including date and time of when something changed value.

### Acting on a record

```ruby
ticket = Ticket.find(1)
ticket.interactions.checkin = true #changes state
ticket.interactions.checkin.toggle #changes state to opposite of current state
ticket.interactions.checkin.undo! #undoes (hard delete) last state
ticket.interactions.checkin #just returns latest value for the checkin key
ticket.interactions.checkin? #just checks if value == true
ticket.interactions.limit(5).checkin #just returns last 5 values for checkin
ticket.interactions.limit(5).oldest.checkin #just returns first 5 (oldest) values for checkin
ticket.interactions #full list of interaction objects
```

### Acting on a table

**Note:** These methods return the objects they are performed on (in this case Ticket).

```ruby
event = Event.find(1)
event.tickets.where("interactions.confirmed = true") #confirmed tickets for event #1
event.tickets.where("interactions.confirmed != true") #unconfirmed tickets for event #1
event.tickets.where("interactions.cancelled = true") #cancelled tickets for event #1
event.tickets.where("interactions.checkin ~ true") #attended tickets for event #1
event.tickets.where("interactions.checkin !~ true") #noshow tickets for event #1
event.tickets.where("interactions.checkin = true") #onsite tickets for event #1
event.tickets.where("interactions.checkin != true") #offsite tickets for event #1
event.tickets.where("interactions.checkin ~ ? AND interactions.created_at < ? AND interactions.created_at > ?", true, Time.now, 3.days.ago) #attended during period
event.tickets.where("interactions.checkin !~ ? AND interactions.created_at < ? AND interactions.created_at > ?", false, Time.now, 3.days.ago) # did not check out during period
event.tickets.where("interactions.permanently_left = true") #not-coming-back
event.tickets.where("interactions.permanently_left != true") #coming-back
```

## Changelog

* 0.0.4 - Added events and venues
* 0.0.3 - Added interactions and interactables
* 0.0.2 - Added emails, tickets, and association
* 0.0.1 - Added basic attendee interface

## License

See LICENSE
