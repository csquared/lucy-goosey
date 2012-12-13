# Lucy::Goosey

Command line parsing sucks.
`Lucy::Goosey` is the New Jersey style approach to the problem.

It assumes some unix conventions, and doesn't mess with your environment or do anything magic.

Heavily tested.

## Examples

```ruby
  options = Lucy::Goosey.parse_options(%w{-n 1})

  options['n']
  # => '1'

  options = Lucy::Goosey.parse_options(%w{-n 1 --foo bar --baz})
  options['n']
  # => '1'

  options['foo']
  # => 'bar'

  options['baz']
  # => true


  options = Lucy::Goosey.parse_options(%w{foo=bar --db postgres:///local-dev-db})

  options['foo']
  # => 'bar'

  options['db']
  # => 'postgres:///local-dev-db'

  options = Lucy::Goosey.parse_options(%w{-n 1 foo=bar -t})
  options['n']
  # => '1'

  options['foo']
  # => 'bar'

  options['t']
  # => true

  options = Lucy::Goosey.parse_options(%w{--this is pretty cool -foo bar --baz})
  options['this']
  # => 'is pretty cool'

  options = Lucy::Goosey.parse_options(%w{ignore leading words --for the win})
  options
  # => {'for' => 'the win'}
```


## Installation

Add this line to your application's Gemfile:

    gem 'lucy-goosey'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lucy-goosey

## Quotes!

    "so simple, I love it!" - Pedro Belo
    "oh thats gross"        - Dane Harrigan

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
