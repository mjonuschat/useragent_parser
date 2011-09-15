require "useragent_parser/version"
require "useragent_parser/parser"

module UseragentParser
  USER_AGENT_PARSERS = []

  def UseragentParser.load_parsers!
    YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../config/user_agent_parser.yaml")['user_agent_parsers'].each do |parser|
      regex = parser['regex']
      family_replacement, v1_replacement = nil, nil
      if parser.has_key?('family_replacement')
        family_replacement = parser['family_replacement']
      end

      if parser.has_key?('v1_replacement')
        v1_replacement = parser['v1_replacement']
      end

      USER_AGENT_PARSERS.push UseragentParser::Parser.new(regex, family_replacement, v1_replacement)
    end
  end

  def UseragentParser.parse(user_agent_string, js_user_agent_string = nil, js_user_agent_family = nil, js_user_agent_v1 = nil, js_user_agent_v2 = nil, js_user_agent_v3 = nil)
    family, v1, v2, v3 = nil, nil, nil, nil
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
      family = 'Chrome Frame (%{family} %{v1})' % { :family => family, :v1 => v1 }
      cf_family, v1, v2, v3 = UseragentParser.parse(js_user_agent_string).values
    end

    { 'family' => family || 'Other', 'v1' => v1, 'v2' => v2, 'v3' => v3 }
  end
end

UseragentParser.load_parsers!
