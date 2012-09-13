require "useragent_parser/version"
require "useragent_parser/parsers/user_agent_parser"
require "useragent_parser/parsers/os_parser"
require "useragent_parser/parsers/device_parser"
require "useragent_parser/user_agent"

module UseragentParser
  USER_AGENT_PARSERS = []
  OS_PARSERS = []
  DEVICE_PARSERS = []
  MOBILE_USER_AGENT_FAMILIES = []
  MOBILE_OS_FAMILIES = []

  def self.load_parsers!
    yaml = YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../config/regexes.yaml")
    yaml['user_agent_parsers'].each do |parser|
      regex = parser['regex']
      family_replacement = parser.fetch('family_replacement', nil)
      v1_replacement = parser.fetch('v1_replacement', nil)

      USER_AGENT_PARSERS.push UseragentParser::UserAgentParser.new(regex, family_replacement, v1_replacement)
    end

    yaml['os_parsers'].each do |parser|
      regex = parser['regex']
      os_replacement = parser.fetch('os_replacement', nil)

      OS_PARSERS.push UseragentParser::OSParser.new(regex, os_replacement)
    end

    yaml['device_parsers'].each do |parser|
      regex = parser['regex']
      device_replacement = parser.fetch('device_replacement', nil)

      DEVICE_PARSERS.push UseragentParser::DeviceParser.new(regex, device_replacement)
    end

    MOBILE_USER_AGENT_FAMILIES.push *yaml['mobile_user_agent_families']
    MOBILE_OS_FAMILIES.push *yaml['mobile_os_families']
  end

  def self.parse_all(user_agent_string, *js_args)
    # UseragentParser::UserAgent.new{
    {
      'user_agent'  => self.parse_user_agent(user_agent_string, *js_args),
      'os'          => self.parse_os(user_agent_string, *js_args),
      'device'      => self.parse_device(user_agent_string, *js_args),
      'string'      => user_agent_string
    }
  end

  def self.parse_user_agent(user_agent_string, js_user_agent_string = nil, js_user_agent_family = nil, js_user_agent_v1 = nil, js_user_agent_v2 = nil, js_user_agent_v3 = nil)
    family, v1, v2, v3 = nil
    # Override via JS properties.
    if js_user_agent_family.nil?
      USER_AGENT_PARSERS.each do |parser|
        family, v1, v2, v3 = parser.parse(user_agent_string)
        break unless family.nil?
      end
    else
      family = js_user_agent_family
      v1 = js_user_agent_v1 unless js_user_agent_v1.nil?
      v2 = js_user_agent_v2 unless js_user_agent_v3.nil?
      v3 = js_user_agent_v3 unless js_user_agent_v3.nil?
    end

    # Override for Chrome Frame IFF Chrome is enabled.
    if js_user_agent_string && js_user_agent_string.include?('Chrome/') && user_agent_string.include?('chromeframe')
      family = 'Chrome Frame (%s %s)' % [ family, v1 ]
      js_ua = self.parse_user_agent(js_user_agent_string)
      cf_family, v1, v2, v3 = js_ua['family'], js_ua['major'], js_ua['minor'], js_ua['patch']
    end

    family ||= 'Other'
    { 'family' => family, 'major' => v1, 'minor' => v2, 'patch' => v3 }
  end

  def self.parse_os(user_agent_string, js_user_agent_string = nil, js_user_agent_family = nil, js_user_agent_v1 = nil, js_user_agent_v2 = nil, js_user_agent_v3 = nil)
    os, os_v1, os_v2, os_v3, os_v4 = nil, nil, nil, nil, nil
    OS_PARSERS.each do |parser|
      os, os_v1, os_v2, os_v3, os_v4 = parser.parse(user_agent_string)
      break unless os.nil?
    end

    os ||= 'Other'
    { 'family' => os, 'major' => os_v1, 'minor' => os_v2, 'patch' => os_v3, 'patch_minor' => os_v4 }
  end

  def self.parse_device(user_agent_string, ua_family = nil, os_family = nil)
    device = nil
    DEVICE_PARSERS.each do |parser|
      device = parser.parse(user_agent_string)
      break unless device.nil?
    end

    os_family = device || 'Other'

    ua_family = self.parse_user_agent(user_agent_string)['family'] if ua_family.nil?
    os_family = self.parse_os(user_agent_string)['family'] if os_family.nil?

    if MOBILE_USER_AGENT_FAMILIES.include?(ua_family)
      is_mobile = true
    elsif MOBILE_OS_FAMILIES.include?(os_family)
      is_mobile = true
    else
      is_mobile = false
    end

    { 'family' => device, 'is_mobile' => is_mobile, 'is_spider' => (device == 'Spider') }
  end
end

UseragentParser.load_parsers!
