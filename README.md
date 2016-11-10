# require_latest

Not many but at least for me helpfull lines of code which basically introduce one single command:

```ruby
require_latest 'GEMNAME'
```

I think it's pretty self-explanatory. Require the latest version - install it first if necessary - without
stopping the script execution. It's originally intended as way to auto-deploy new version of my projects to
my colleagues who barely update their stuff and therefore might miss an important change, but there might be
other usefull purposes. Please feel free to contact me and tell me your use-cases.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'require_latest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install require_latest

## Usage

Its as simple as this:

```ruby
require 'require_latest'

require_latest 'fxruby'
```

## TODO

Write some tests, but its actually quite hard to test this, as it requires to have some local gems, that are outdated or not installed at all.
So the test would have to scan the local system first to find suitable gems for the test and uninstall them afterwards, because there might be
a good reason the tester hasn't updated that specific one.

## Development

There are no dependencies to install. Just run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kjarrigan/require_latest.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

