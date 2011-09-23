# encoding: utf-8

require 'spec_helper'

describe UseragentParser do
  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/test_user_agent_parser.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '"))
        js_ua = [ js_ua['js_user_agent_string'], js_ua['js_user_agent_family'], js_ua['js_user_agent_v1'], js_ua['js_user_agent_v2'], js_ua['js_user_agent_v3'] ]
      end
      result = UseragentParser.parse(testcase['user_agent_string'], *js_ua)
      result.browser_family.should        == testcase['family']
      result.browser_major_version.should == testcase['v1']
      result.browser_minor_version.should == testcase['v2']
      result.browser_patch_version.should == testcase['v3']
      result.os_family.should             == testcase['os_family']
      result.os_major_version.should      == testcase['os_v1']
      result.os_minor_version.should      == testcase['os_v2']
      result.os_patch_version.should      == testcase['os_v3']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/firefox_user_agent_strings.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse(testcase['user_agent_string'], *js_ua)
      result.browser_family.should        == testcase['family']
      result.browser_major_version.should == testcase['v1']
      result.browser_minor_version.should == testcase['v2']
      result.browser_patch_version.should == testcase['v3']
    end
  end

  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/pgts_browser_list.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the useragent header '#{testcase['user_agent_string']}'" do
      js_ua = {}
      if testcase['js_ua']
        js_ua = eval(testcase['js_ua'].gsub("': '", "' => '")).values
      end
      result = UseragentParser.parse(testcase['user_agent_string'], *js_ua)
      result.browser_family.should        == testcase['family']
      result.browser_major_version.should == testcase['v1']
      result.browser_minor_version.should == testcase['v2']
      result.browser_patch_version.should == testcase['v3']
    end
  end
end
