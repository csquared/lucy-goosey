# Lucy

Command line parsing sucks.
`Lucy` is the New Jersey style approach to the problem.

She's a good citizen: assumes some unix conventions, doesn't mess with your environment, and doesn't do anything magic.

Heavily tested.

## Examples

```ruby
  options = Lucy.parse_options(%w{-n 1})

  options['n']
  # => '1'

  options = Lucy.parse_options(%w{--n 1 --foo bar --baz})

  options['n']
  # => '1'

  options['foo']
  # => 'bar'

  options['baz']
  # => true
```


## Installation

Add this line to your application's Gemfile:

    gem 'lucy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lucy

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
