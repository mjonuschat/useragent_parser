# encoding: utf-8

module UseragentParser
  class OSParser
    attr_accessor :pattern, :user_agent_re, :family_replacement, :major_replacement

    def initialize(pattern, os_replacement = nil)
      @pattern = pattern
      @user_agent_re = Regexp.compile(pattern)
      @os_replacement = os_replacement
    end

    def match_spans(user_agent_string)
      match_spans = []
      match = @user_agent_re.match(user_agent_string)
      if match
        # Return the offsets
      end
    end

    def parse(user_agent_string)
      os, os_v1, os_v2, os_v3, os_v4 = nil, nil, nil, nil, nil
      match = @user_agent_re.match(user_agent_string)
      if match
        if @os_replacement
          os = @os_replacement
        else
          os = match[1]
        end

        os_v1 = match[2] if match.size >= 3
        os_v2 = match[3] if match.size >= 4
        os_v3 = match[4] if match.size >= 5
        os_v4 = match[5] if match.size >= 6
      end
      return os, os_v1, os_v2, os_v3, os_v4
    end
  end
end
