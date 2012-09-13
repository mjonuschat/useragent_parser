# encoding: utf-8

require 'spec_helper'

describe UseragentParser::OSParser do
  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/test_user_agent_parser_os.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '"))
        js_ua = [ js_ua['js_user_agent_string'], js_ua['js_user_agent_family'], js_ua['js_user_agent_v1'], js_ua['js_user_agent_v2'], js_ua['js_user_agent_v3'] ]
      end
      result = UseragentParser.parse_os(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['major'].should  == testcase['major']
      result['minor'].should  == testcase['minor']
      result['patch'].should  == testcase['patch']
      result['patch_minor'].should  == testcase['patch_minor']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/additional_os_tests.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '"))
        js_ua = [ js_ua['js_user_agent_string'], js_ua['js_user_agent_family'], js_ua['js_user_agent_v1'], js_ua['js_user_agent_v2'], js_ua['js_user_agent_v3'] ]
      end
      result = UseragentParser.parse_os(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['major'].should  == testcase['major']
      result['minor'].should  == testcase['minor']
      result['patch'].should  == testcase['patch']
      result['patch_minor'].should  == testcase['patch_minor']
    end
  end
end
