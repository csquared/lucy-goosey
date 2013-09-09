require "lucy-goosey/version"

module Lucy
  module Goosey
    UNIX_SINGLE_FLAG = /^-/
    UNIX_DOUBLE_FLAG = /^--/
    EQUAL = /=/

    class OptionsHash < Hash
      attr_accessor :argv

      # Returns true if -h or --help are any of the arg
      # or 'help' is the first word to argv
      def help?
        self['h'] || self['help'] || argv[0] == 'help'
      end
    end

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

    def self.parse(_args)
      self.parse_options(_args)
    end

    # Public: parses array of options, loosely assuming unix-style conventions.
    #
    # Returns a Hash
    def self.parse_options(_args)
      args = _args.dup
      options = OptionsHash.new
      options.argv = _args.dup

      raise ArgumentError, 'must be an array' unless args.is_a? Array
      return options if args.empty?

      args.reverse!
      # get rid of leading words
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

        key = deflag(key)
        options[key] = value
      end

      options
    end
  end
end
