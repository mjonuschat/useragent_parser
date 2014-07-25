# encoding: utf-8

require 'spec_helper'

describe UseragentParser do
  let(:user_agent_string) { 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; fr; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5,gzip(gfe),gzip(gfe)' }

  describe "should return user agent information" do
    subject { UseragentParser.parse_browser(user_agent_string)['user_agent'] }

    describe "['family']" do
      subject { super()['family'] }
      it { is_expected.to eq('Firefox') }
    end

    describe "['major']" do
      subject { super()['major'] }
      it { is_expected.to eq('3') }
    end

    describe "['minor']" do
      subject { super()['minor'] }
      it { is_expected.to eq('5') }
    end

    describe "['patch']" do
      subject { super()['patch'] }
      it { is_expected.to eq('5') }
    end
  end

  describe "should return the operating system information" do
    subject { UseragentParser.parse_browser(user_agent_string)['os'] }

    describe "['family']" do
      subject { super()['family'] }
      it { is_expected.to eq('Mac OS X') }
    end

    describe "['major']" do
      subject { super()['major'] }
      it { is_expected.to eq('10') }
    end

    describe "['minor']" do
      subject { super()['minor'] }
      it { is_expected.to eq('4') }
    end

    describe "['patch']" do
      subject { super()['patch'] }
      it { is_expected.to be_nil }
    end

    describe "['patch_minor']" do
      subject { super()['patch_minor'] }
      it { is_expected.to be_nil }
    end
  end

  describe "should return the device information" do
    subject { UseragentParser.parse_browser(user_agent_string)['device'] }

    describe "['family']" do
      subject { super()['family'] }
      it { is_expected.to be_nil }
    end

    describe "['is_spider']" do
      subject { super()['is_spider'] }
      it { is_expected.to be_falsey }
    end

    describe "['is_mobile']" do
      subject { super()['is_mobile'] }
      it { is_expected.to be_falsey }
    end
  end
end
