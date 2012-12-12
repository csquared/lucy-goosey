require "lucy-goosey/version"

module Lucy
  module Goosey
    UNIX_SINGLE_FLAG = /^-/
    UNIX_DOUBLE_FLAG = /^--/
    EQUAL = /=/


    def self.magic_word?(word)
      return unless word
      (self.flag?(word) || word.match(EQUAL))
    end

    def self.flag?(word)
      return unless word
      word.match(UNIX_DOUBLE_FLAG) || word.match(UNIX_SINGLE_FLAG)
    end

    def self.deflag(word)
      word.sub(UNIX_DOUBLE_FLAG, '').sub(UNIX_SINGLE_FLAG,'')
    end


    def self.parse_options(_args)
      args = _args.dup
      config = {}

      raise ArgumentError, 'must be an array' unless args.is_a? Array
      return config if args.empty?

      args.reverse!
      args.pop while args.last && !magic_word?(args.last)

      args.size.times do
        break if args.empty?
        head = args.pop
        peek = args.last

        key, value = nil, nil
        if head.match(/=/)
          key, value = head.split('=', 2)
        elsif peek.nil? || magic_word?(peek)
          key, value  = head, true
        elsif peek
          key, value = head, [args.pop]
          value << args.pop while (args.last && !magic_word?(args.last))
          value = value.join(' ')
        end
        next unless key and value

        value = true if value == 'true'
        key = deflag(key)
        config[key] = value
      end

      config
    end
  end
end
