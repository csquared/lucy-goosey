require "lucy-goosey/version"

module Lucy
  module Goosey
    def self.parse_options(_args)
      args = _args.dup
      config = {}
      flag = /^--/

      args.size.times do
        break if args.empty?
        arg  = args.shift
        peek = args.first
        key  = arg
        if key.match(/=/)
          key, value = key.split('=', 2)
        elsif peek && peek.match(/=/)
          config[key.sub(flag, '')] = true
          key, value = peek.split('=', 2)
        elsif peek.nil? || peek.match(flag)
          value = true
        else
          value = args.shift
        end
        value = true if value == 'true'
        config[key.sub(flag, '')] = value
      end

      config
    end
  end
end
