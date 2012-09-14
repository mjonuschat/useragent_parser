# encoding: utf-8

require 'spec_helper'

describe UseragentParser::ReferrerParser do
  YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../fixtures/test_referrers.yaml")['test_cases'].each do |testcase|
    it "should correctly parse the referrer string '#{testcase['referrer_string']}'" do
      result = UseragentParser.parse_referrer(testcase['referrer_string'])
      result['family'].should     == testcase['family']
    end
  end
end
