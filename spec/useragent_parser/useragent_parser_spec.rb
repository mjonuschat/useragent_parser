# encoding: utf-8

require 'spec_helper'
require 'useragent_parser'

describe UseragentParser do
  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/test_user_agent_parser.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse(testcase['user_agent_string'], *js_ua)
      result['family'].should     == testcase['family']
      result['v1'].should         == testcase['v1']
      result['v2'].should         == testcase['v2']
      result['v3'].should         == testcase['v3']
      result['os_family'].should  == testcase['os_family']
      result['os_v1'].should      == testcase['os_v1']
      result['os_v2'].should      == testcase['os_v2']
      result['os_v3'].should      == testcase['os_v3']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/firefox_user_agent_strings.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['v1'].should     == testcase['v1']
      result['v2'].should     == testcase['v2']
      result['v3'].should     == testcase['v3']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/pgts_browser_list.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse(testcase['user_agent_string'], *js_ua)
      result['family'].should == testcase['family']
      result['v1'].should     == testcase['v1']
      result['v2'].should     == testcase['v2']
      result['v3'].should     == testcase['v3']
    end
  end
end
