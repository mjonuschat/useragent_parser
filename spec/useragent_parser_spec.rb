# encoding: utf-8

require 'spec_helper'

describe UseragentParser do
  let(:user_agent_string) { 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; fr; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5,gzip(gfe),gzip(gfe)' }

  describe "should return user agent information" do
    subject { UseragentParser.parse_browser(user_agent_string)['user_agent'] }

    its(['family']) { should == 'Firefox' }
    its(['major']) { should == '3' }
    its(['minor']) { should == '5' }
    its(['patch']) { should == '5' }
  end

  describe "should return the operating system information" do
    subject { UseragentParser.parse_browser(user_agent_string)['os'] }

    its(['family']) { should == 'Mac OS X' }
    its(['major']) { should == '10' }
    its(['minor']) { should == '4' }
    its(['patch']) { should be_nil }
    its(['patch_minor']) { should be_nil }
  end

  describe "should return the device information" do
    subject { UseragentParser.parse_browser(user_agent_string)['device'] }

    its(['family']) { should be_nil }
    its(['is_spider']) { should be_false }
    its(['is_mobile']) { should be_false }
  end
end
