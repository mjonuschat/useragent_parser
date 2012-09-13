# encoding: utf-8

module UseragentParser
  class DeviceParser
    attr_accessor :pattern, :user_agent_re, :device_replacement

    def initialize(pattern, device_replacement = nil)
      @pattern = pattern
      @user_agent_re = Regexp.compile(pattern)
      @device_replacement = device_replacement
    end

    def match_spans(user_agent_string)
      match_spans = []
      match = @user_agent_re.match(user_agent_string)
      if match
        # Return the offsets
      end
    end

    def parse(user_agent_string)
      device = nil
      match = @user_agent_re.match(user_agent_string)
      if match
        if @device_replacement
          if %r'\$1'.match @device_replacement
            device = @device_replacement.gsub(%r'\$1', match[1])
          else
            device = @device_replacement
          end
        else
          device = match[1]
        end
      end
      return device
    end
  end
end
