[![Build Status](https://travis-ci.org/westfieldlabs/status_querier.svg?branch=master)](https://travis-ci.org/westfieldlabs/status_querier)
# StatusQuerier

`StatusQuerier` gives the ability to safely combine scopes with `or` method given by the `where-or` gem. It restricts the scopes to the allowable 6 types. `pending`, `preview`, `live`, `expired`, `invalid`, and `disabled`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'status_querier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install status_querier

## Usage

To use, copy the following into your model.

```ruby
include StatusQuerier::Querier
```

And now you can call `Model.with_any_statuses(['preview', 'live'])`


## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake spec` to run the tests.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/westfield/status_querier.

