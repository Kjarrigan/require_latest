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

```ruby

require 'require_latest'

# 1) basic usage for gems on https://rubygems.org
require_latest 'nokogiri'

# version 2 for gems where package and require names are different
require_latest 'fxruby', require: 'fox16'

# version 3 for gems on a different server (like a custom company gem-server)
require_latest 'simple-logger', src: 'http://localgemserver:1234'

# version 4 as combination of 2+3
require_latest 'foo', require: 'bar', src: 'http://example.com'
```

## TODO

Write some tests, but its actually quite hard to test this, as it requires to have some local gems, that are outdated or not installed at all.
So the test would have to scan the local system first to find suitable gems for the test and uninstall them afterwards, because there might be
a good reason the tester hasn't updated that specific one.

## Development

There are no dependencies to install. You can run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kjarrigan/require_latest.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

