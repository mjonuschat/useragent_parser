# encoding: utf-8

require 'spec_helper'

describe UseragentParser::UserAgent do
  describe "for browser details" do
    it "should report the browser family" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_family.should == 'Chrome'
    end

    it "should report the browser major version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_major_version.should == '14'
    end

    it "should report the browser minor version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_minor_version.should == '0'
    end

    it "should report the browser patch version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_patch_version.should == '835'
    end

    it "should report the browser version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } }).browser_version.should == '14.0.835'
    end

    it "should report the browser version without patch level" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Firefox', 'major' => '5', 'minor' => '0' } }).browser_version.should == '5.0'
    end

    it "should report the browser version without minor version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Firefox', 'major' => '5' } }).browser_version.should == '5'
    end

    it "should report the browser family without version" do
      UseragentParser::UserAgent.new({ 'user_agent' => { 'family' => 'Opera' } }).browser_version.should == ''
    end
  end

  describe "for device details" do
    it "should report mobile classification" do
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => false, 'is_spider' => false } }).is_mobile?.should be_false
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => true, 'is_spider' => false } }).is_mobile?.should be_true
    end

    it "should report spider classification" do
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => false, 'is_spider' => false } }).is_spider?.should be_false
      UseragentParser::UserAgent.new({ 'device' => { 'family' => nil, 'is_mobile' => false, 'is_spider' => true } }).is_spider?.should be_true
    end

    it "should report device platform" do
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'iPad', 'is_mobile' => true, 'is_spider' => false } }).device.should == "iPad"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'iPod', 'is_mobile' => true, 'is_spider' => false } }).device.should == "iPod"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'iPhone', 'is_mobile' => true, 'is_spider' => false } }).device.should == "iPhone"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'GT-P7510', 'is_mobile' => true, 'is_spider' => false } }).device.should == "GT-P7510"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'Blackberry Playbook', 'is_mobile' => true, 'is_spider' => false } }).device.should == "Blackberry Playbook"
      UseragentParser::UserAgent.new({ 'device' => { 'family' => 'Spider', 'is_mobile' => false, 'is_spider' => true } }).device.should == "Spider"
    end
  end

  describe "for email client" do
    it "should detect Mozilla Thunderbird" do
      UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10.4; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9').email.should == 'Thunderbird'
    end

    it "should detect Windows Live Mail" do
      UseragentParser.parse_with_referrer('Outlook-Express/7.0 (MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618; TmstmpExt)').email.should == 'Windows Live Mail'
    end

    it "should detect Eudora" do
      UseragentParser.parse_with_referrer('Eudora/6.2.3b9 (MacOS)').email.should == 'Eudora'
    end

    it "should detect T-Online eMail" do
      UseragentParser.parse_with_referrer('Kopernikus T-Online eMail 3.x').email.should == 'T-Online eMail'
    end

    it "should detect old Apple Mail" do
      UseragentParser.parse_with_referrer('Mail/1082 CFNetwork/454.11.5 Darwin/10.5.0 (i386) (MacBookPro6%2C2)').email.should == 'Apple Mail'
    end

    it "should detect newer Apple Mail" do
      UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; de-de) AppleWebKit/533.18.1 (KHTML, like Gecko)').email.should == 'Apple Mail'
    end

    it "should detect Lotus Notes" do
      UseragentParser.parse_with_referrer('Mozilla/4.0 (compatible; Lotus-Notes/6.0; Macintosh PPC)').email.should == 'Lotus Notes'
    end

    it "should detect Microsoft Outlook" do
      UseragentParser.parse_with_referrer('Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 1.1.4322; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; ms-office; MSOffice 14)').email.should == 'Microsoft Outlook'
    end

    it "should detect Sparrow" do
      UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8) AppleWebKit/536.25 (KHTML, like Gecko) Sparrow/1164').email.should == 'Sparrow'
    end

    describe "Outlook" do
      it "should should recognize Outlook 2000/2003/Express" do
        UseragentParser.parse_with_referrer('Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)').email_version.should == 'Outlook 2000/2003/Express'
      end

      it "should not mistake IE7 as Outlook" do
        # TODO
      end

      it "should should recognize Outlook 2007" do
        UseragentParser.parse_with_referrer('Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2; MSOffice 12)').email_version.should == 'Outlook 2007'
      end

      it "should should recognize Outlook 2010" do
        UseragentParser.parse_with_referrer('Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; InfoPath.3; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0C; .NET4.0E; ms-office; MSOffice 14)').email_version.should == 'Outlook 2010'
      end

      it "should should recognize Outlook 2013" do
        UseragentParser.parse_with_referrer('Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; Tablet PC 2.0; InfoPath.3; BOIE9;ENIN; Microsoft Outlook 15.0.4128; ms-office; MSOffice 15)').email_version.should == 'Outlook 2013'
      end
    end

    describe "Apple Mail" do
      it "should recognize Version 2" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; de-de) AppleWebKit/533.19.4 (KHTML, like Gecko)').email_version.should == 'Apple Mail 2'
      end

      it "should recognize Version 3" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; de-de) AppleWebKit/533.18.1 (KHTML, like Gecko)').email_version.should == 'Apple Mail 3'
      end

      it "should recognize Version 4" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; de-de) AppleWebKit/533.19.4 (KHTML, like Gecko)').email_version.should == 'Apple Mail 4'
      end

      it "should recognize Version 5" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/534.53.11 (KHTML, like Gecko)').email_version.should == 'Apple Mail 5'
      end

      it "should recognize Version 6" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_1) AppleWebKit/536.25 (KHTML, like Gecko)').email_version.should == 'Apple Mail 6'
      end

      it "should not mistake Safari for Apple Mail" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_1) AppleWebKit/536.25 (KHTML, like Gecko)', 'something').email_version.should be_nil
      end
    end

    describe "Apple Mobile Mail" do
      it "should recognize an iPad" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (iPad; U; CPU OS 3_2_2 like Mac OS X; de-de) AppleWebKit/531.21.10 (KHTML, like Gecko)').email_version.should == 'iPad'
      end

      it "should recognize an iPod" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (iPod; U; CPU iPhone OS 4_0 like Mac OS X; de-de) AppleWebKit/532.9 (KHTML, like Gecko)').email_version.should == 'iPod'
      end

      it "should recognize an iPhone" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0_1 like Mac OS X; de-de) AppleWebKit/532.9 (KHTML, like Gecko)').email_version.should == 'iPhone'
      end

      it "should not mistake Mobile Safari for Apple Mail" do
        # TODO
      end
    end

    describe "AOL" do
      it "should recognize the Webmail interface" do
        UseragentParser.parse_with_referrer('Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101203 AskTbFXTV5/3.9.1.14019 Firefox/3.6.13', 'http://mail.aol.com/33222-111/aol-1/de-de/Lite/MsgRead.aspx?folder=Spam&uid=1.28305313&seq=0&searchIn=none&searchQuery=&start=0&sort=received').email.should == 'AOL Webmail'
      end
    end
  end

  describe "for operating system details" do
    it "should report the os family" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_family.should == 'Windows NT'
    end

    it "should report the major os version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_major_version.should == '3'
    end

    it "should report the minor os version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_minor_version.should == '1'
    end

    it "should report the os patchlevel" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_patch_version.should be_nil
    end

    it "should report the os version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os_version.should == '3.1'
    end

    it "should know the code name for Windows NT 3.1" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '1' } }).os.should == 'Microsoft Windows NT 3.1'
    end

    it "should know the code name for Windows NT 3.5" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '3', 'minor' => '5' } }).os.should == 'Microsoft Windows NT 3.5'
    end

    it "should know the code name for Windows NT 4.0" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '4', 'minor' => '0' } }).os.should == 'Microsoft Windows NT 4.0'
    end

    it "should know the code name for Windows 2000" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '5', 'minor' => '0' } }).os.should == 'Microsoft Windows 2000'
    end

    it "should know the code name for Windows XP" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '5', 'minor' => '1' } }).os.should == 'Microsoft Windows XP'
    end

    it "should know the code name for Windows XP 64bit / Server 2003" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '5', 'minor' => '2' } }).os.should == 'Microsoft Windows XP 64bit / Server 2003'
    end

    it "should know the code name for Windows Vista / Server 2008" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '6', 'minor' => '0' } }).os.should == 'Microsoft Windows Vista / Server 2008'
    end

    it "should know the code name for Windows 7 / Server 2008 R2" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '6', 'minor' => '1' } }).os.should == 'Microsoft Windows 7 / Server 2008 R2'
    end

    it "should know the code name for Windows 8" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows NT', 'major' => '6', 'minor' => '2' } }).os.should == 'Microsoft Windows 8'
    end

    it "should know the code name for Windows 3.1" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '3', 'minor' => '1' } }).os.should == 'Microsoft Windows 3.1'
    end

    it "should know the code name for Windows 95" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '95' } }).os.should == 'Microsoft Windows 95'
    end

    it "should know the code name for Windows 98" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '98' } }).os.should == 'Microsoft Windows 98'
    end

    it "should know the code name for Windows ME" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => 'ME' } }).os.should == 'Microsoft Windows ME'
    end

    it "should know the code name for Windows 9x" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Windows', 'major' => '9x' } }).os.should == 'Microsoft Windows 9x'
    end

    it "should know the code name for Mac OS X 10.0" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '0' } }).os.should == 'Apple Mac OS X 10.0 (Cheetah)'
    end

    it "should know the code name for Mac OS X 10.0" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '0', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.0.2 (Cheetah)'
    end

    it "should know the code name for Mac OS X 10.1" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '1', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.1.2 (Puma)'
    end

    it "should know the code name for Mac OS X 10.2" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '2', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.2.2 (Jaguar)'
    end

    it "should know the code name for Mac OS X 10.3" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '3', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.3.2 (Panther)'
    end

    it "should know the code name for Mac OS X 10.4" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '4', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.4.2 (Tiger)'
    end

    it "should know the code name for Mac OS X 10.5" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '5', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.5.2 (Leopard)'
    end

    it "should know the code name for Mac OS X 10.6" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '6', 'patch' => 2 } }).os.should == 'Apple Mac OS X 10.6.2 (Snow Leopard)'
    end

    it "should know the code name for Mac OS X 10.7" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '7', 'patch' => '2' } }).os.should == 'Apple Mac OS X 10.7.2 (Lion)'
    end

    it "should provide a generic os/version for other operating systems" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Linux', 'major' => '2', 'minor' => '6', 'patch' => '32' } }).os.should == 'Linux 2.6.32'
    end

    it "should provide a generic os name without version" do
      UseragentParser::UserAgent.new({ 'os' => { 'family' => 'FreeBSD' } }).os.should == 'FreeBSD'
    end
  end

  it "should combing operating system and browser version" do
    ua = UseragentParser::UserAgent.new({ 'os' => { 'family' => 'Mac OS X', 'major' => '10', 'minor' => '7', 'patch' => '2' }, 'user_agent' => { 'family' => 'Chrome', 'major' => '14', 'minor' => '0', 'patch' => '835' } })
    ua.browser_family.should == 'Chrome'
    ua.browser_version.should == '14.0.835'
    ua.os_family.should == 'Mac OS X'
    ua.os_version.should == '10.7.2'
  end
end
