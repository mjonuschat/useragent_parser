# encoding: utf-8

module UseragentParser
  class ReferrerParser
    attr_accessor :pattern, :referrer_re, :referrer_replacement

    def initialize(pattern, referrer_replacement = nil)
      @pattern = pattern
      @referrer_re = Regexp.compile(pattern)
      @referrer_replacement = referrer_replacement
    end

    def match_spans(referrer_string)
      match_spans = []
      match = @referrer_re.match(referrer_string)
      if match
        # Return the offsets
      end
    end

    def parse(referrer_string)
      referrer = nil
      match = @referrer_re.match(referrer_string)
      if match
        if @referrer_replacement
          referrer = @referrer_replacement
        else
          referrer = match[1]
        end
      end
      return referrer
    end
  end
end
