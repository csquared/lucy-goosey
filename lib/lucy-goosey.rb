require "lucy-goosey/version"

module Lucy
  module Goosey
    UNIX_SINGLE_FLAG = /^-/
    UNIX_DOUBLE_FLAG = /^--/
    EQUAL = /=/


    def self.leading_word?(word)
      ! (word.match(UNIX_DOUBLE_FLAG) || word.match(UNIX_SINGLE_FLAG) || word.match(EQUAL))
    end


    def self.parse_options(_args)
      args = _args.dup
      config = {}

      raise ArgumentError, 'must be an array' unless _args.is_a? Array
      return config if _args.empty?

      args = args[1..-1] while leading_word?(args.first)

      args.size.times do
        break if args.empty?
        arg  = args.shift
        peek = args.first
        key  = arg
        if key.match(/=/)
          key, value = key.split('=', 2)
        elsif peek && peek.match(/=/)
          config[key.sub(UNIX_DOUBLE_FLAG, '')] = true
          key, value = peek.split('=', 2)
        elsif peek.nil? || peek.match(UNIX_DOUBLE_FLAG) || peek.match(UNIX_SINGLE_FLAG)
          value = true
        else
          value = args.shift
        end
        value = true if value == 'true'
        key = key.sub(UNIX_DOUBLE_FLAG, '').sub(UNIX_SINGLE_FLAG,'')
        config[key] = value
      end

      config
    end
  end
end
