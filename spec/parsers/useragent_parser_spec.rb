# encoding: utf-8

require 'spec_helper'

describe UseragentParser::UserAgentParser do
  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/test_user_agent_parser.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '"))
        js_ua = [ js_ua['js_user_agent_string'], js_ua['js_user_agent_family'], js_ua['js_user_agent_v1'], js_ua['js_user_agent_v2'], js_ua['js_user_agent_v3'] ]
      end
      result = UseragentParser.parse_user_agent(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['major'].should  == testcase['major']
      result['minor'].should  == testcase['minor']
      result['patch'].should  == testcase['patch']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/firefox_user_agent_strings.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse_user_agent(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['major'].should  == testcase['major']
      result['minor'].should  == testcase['minor']
      result['patch'].should  == testcase['patch']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/pgts_browser_list.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse_user_agent(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['major'].should  == testcase['major']
      result['minor'].should  == testcase['minor']
      result['patch'].should  == testcase['patch']
    end
  end
end
