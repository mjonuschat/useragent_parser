# encoding: utf-8

require 'spec_helper'

describe UseragentParser::DeviceParser do
  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/test_device.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '"))
        js_ua = [ js_ua['js_user_agent_string'], js_ua['js_user_agent_family'], js_ua['js_user_agent_v1'], js_ua['js_user_agent_v2'], js_ua['js_user_agent_v3'] ]
      end
      result = UseragentParser.parse_device(testcase['user_agent_string'], *js_ua)
      expect(result['family']).to     eq(testcase['family'])
      expect(result['is_mobile']).to  eq(testcase['is_mobile'])
      expect(result['is_spider']).to  eq(testcase['is_spider'])
    end
  end
end
