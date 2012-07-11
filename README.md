# keeper

[![Build Status](https://secure.travis-ci.org/geeksoflondon/keeper.png?branch=master)](http://travis-ci.org/geeksoflondon/keeper)

The zoo keeper that allows all animals to talk to the hamster

## Intallation

Add to Gemfile for a Rails app:

```ruby
gem "gol-keeper", require: "keeper"
```

Bundle and then add a `config/keeper.yml`

```yml
host: http://localhost:3000/
user: "username"
password: "password"
```

Or don't add the yml file to fall back on the ENV variables `KEEPER_HOST`, `KEEPER_USER` and `KEEPER_PASSWORD`. This is useful for Heroku

## Usage

For now Keeper adds a few build in ActiveResource classes. For full usage details read the [ActiveResource documentation](http://api.rubyonrails.org/classes/ActiveResource/Base.html).

```ruby
Keeper::Attendee.find(1)
#=> #<Attendee:0x007f9aabb84550 @attributes={"created_at"=>"2012-07-10T19:26:23Z", "diet"=>nil, "first_name"=>"John", "id"=>1, "kind"=>1, "last_name"=>"Doe", "name"=>"John Doe", "notes"=>nil, "phone_number"=>nil, "public"=>true, "tshirt"=>nil, "twitter"=>nil, "updated_at"=>"2012-07-10T19:26:23Z"}, @prefix_options={}, @persisted=true>
```

Alternatively you can make your own models to extend the base classes:

```ruby
# in app/models/attendee.yml

class Attendee < Keeper::Attendee
  # add your own convenience methods here
end

# anywhere else
Attendee.find(1)
#=> #<Attendee:0x007f9aabb84550 @attributes={"created_at"=>"2012-07-10T19:26:23Z", "diet"=>nil, "first_name"=>"John", "id"=>1, "kind"=>1, "last_name"=>"Doe", "name"=>"John Doe", "notes"=>nil, "phone_number"=>nil, "public"=>true, "tshirt"=>nil, "twitter"=>nil, "updated_at"=>"2012-07-10T19:26:23Z"}, @prefix_options={}, @persisted=true>
```

## License

See LICENSE
