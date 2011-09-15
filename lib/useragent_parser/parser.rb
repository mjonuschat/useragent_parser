# encoding: utf-8

module UseragentParser
  class Parser
    attr_accessor :pattern, :user_agent_re, :family_replacement, :v1_replacement

    def initialize(pattern, family_replacement = nil, v1_replacement = nil)
      @pattern = pattern
      @user_agent_re = Regexp.compile(pattern)
      @family_replacement = family_replacement
      @v1_replacement = v1_replacement
    end

    def match_spans(user_agent_string)
      match_spans = []
      match = @user_agent_re.match(user_agent_string)
      if match
        # Return the offsets
      end
    end

    def parse(user_agent_string)
      family, v1, v2, v3 = nil, nil, nil, nil
      match = @user_agent_re.match(user_agent_string)
      if match
        family = match[1]
        if @family_replacement
          if %r'\$1'.match @family_replacement
            family = @family_replacement.gsub(%r'\$1', match[1])
          else
            family = @family_replacement
          end
        end

        if @v1_replacement
          v1 = @v1_replacement
        else
          v1 = match[2]
        end

        if match.size >= 4
          v2 = match[3]
          if match.size >= 5
            v3 = match[4]
          end
        end
      end
      return family, v1, v2, v3
    end
  end
end
