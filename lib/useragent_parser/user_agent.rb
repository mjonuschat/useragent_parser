module UseragentParser
  class UserAgent
    attr_reader :browser, :browser_family, :browser_version, :browser_major_version, :browser_minor_version, :browser_patch_version
    attr_reader :os, :os_family, :os_version, :os_major_version, :os_minor_version, :os_patch_version
    attr_reader :webmail_client

    def initialize(details = {})
      if user_agent = details['user_agent']
        @browser_family = user_agent['family'] || 'Other'
        @browser_major_version = user_agent['major']
        @browser_minor_version = user_agent['minor']
        @browser_patch_version = user_agent['patch']
      end

      if os = details['os']
        @os_family = os['family'] || 'Other'
        @os_major_version = os['major']
        @os_minor_version = os['minor']
        @os_patch_version = os['patch']
      end

       if device = details['device']
         @device = device['family']
         @is_mobile = device['is_mobile']
         @is_spider = device['is_spider']
       end

       if referrer = details['referrer']
        @webmail_client = referrer['family']
      end
    end

    def device
      @device
    end

    def is_mobile?
      !!@is_mobile
    end

    def is_spider?
      !!@is_spider
    end

    def browser_version
      @browser_version ||= "#{browser_major_version}.#{browser_minor_version}.#{browser_patch_version}".gsub(/\.+$/, '').strip
    end

    def os_version
      @os_version ||= "#{os_major_version}.#{os_minor_version}.#{os_patch_version}".gsub(/\.+$/, '').strip
    end

    def os
      @os ||= os_name
    end

    def browser
      @browser ||= browser_name
    end

    def email
      @email ||= email_name
    end

    def email_version
      @email_version ||= email_version_name
    end

    def is_email?
      is_outlook? || is_ios_mail? || is_apple_mail? || is_desktop_email? || is_webmail?
    end

    protected

    def is_desktop_email?
      [
        "Thunderbird",
        "T-Online eMail",
        "Eudora",
        "Apple Mail",
        "Sparrow",
        "Lotus Notes",
        "Windows Live Mail",
        "Outlook",
        "AOL"
      ].include? @browser_family
    end

    def is_ios_mail?
      @webmail_client.nil?  && @browser_family == 'Mobile Safari' && @os_family == 'iOS'
    end

    def is_apple_mail?
      @webmail_client.nil? && @browser_family == 'Apple WebKit' && @os_family == 'Mac OS X'
    end

    def is_webmail?
      [
        "Hotmail",
        "Yahoo! Mail",
        "WEB.DE",
        "AOL Webmail",
        "Gmail",
        "GMX",
        "Swisscom",
        "Strato",
        "mail.ru"
      ].include?(@webmail_client)
    end

    def is_aol?
      @browser_family == 'AOL' || @webmail_client == 'AOL Webmail'
    end

    def is_outlook?
      @browser_family == 'Outlook' || (@browser_family == 'IE' and @webmail_client.nil?)
    end

    def email_name
      return 'Microsoft Outlook' if is_outlook?
      return 'Apple Mail' if is_apple_mail?
      return 'Apple Mobile Mail' if is_ios_mail?
      return @browser_family if is_desktop_email?
      return @webmail_client if is_webmail?
      return @os_family if @os_family == 'Android'
      return 'AOL' if is_aol?
    end

    def email_version_name
      return apple_mail_names if is_apple_mail?
      return ios_mail_names if is_ios_mail?
      return outlook_names if is_outlook?
      return 'AOL Desktop' if @browser_family == 'AOL'
      email_name
    end

    def apple_mail_names
      case @os_minor_version
      when '0', '1', '2', '3' then 'Apple Mail 1'
      when '4' then 'Apple Mail 2'
      when '5' then 'Apple Mail 3'
      when '6' then 'Apple Mail 4'
      when '7' then 'Apple Mail 5'
      when '8' then 'Apple Mail 6'
      else 'Apple Mail'
      end
    end

    def ios_mail_names
      @device
    end

    def outlook_names
      return 'Outlook 2000/2003/Express' unless @browser_family == 'Outlook'
      case @browser_major_version
      when '12' then 'Outlook 2007'
      when '14' then 'Outlook 2010'
      when '15' then 'Outlook 2013'
      else 'Outlook'
      end
    end

    def browser_name
      "#{browser_family} #{browser_version}"
    end

    def os_name
      case os_family
      when 'Windows' then os_names_win
      when 'Windows NT' then os_names_winnt
      when 'Mac OS X' then os_names_osx
      else "#{os_family} #{os_version}".strip
      end
    end

    def os_release
      @release ||= "#{os_major_version}.#{os_minor_version}".gsub(/\.$/, '')
    end

    def os_names_win
      "Microsoft Windows #{os_version}"
    end

    def os_names_winnt
      prefix = "Microsoft Windows"
      case os_release
      when "3.1" then "#{prefix} NT 3.1"
      when "3.5" then "#{prefix} NT 3.5"
      when "4.0" then "#{prefix} NT 4.0"
      when "5.0" then "#{prefix} 2000"
      when "5.1" then "#{prefix} XP"
      when "5.2" then "#{prefix} XP 64bit / Server 2003"
      when "6.0" then "#{prefix} Vista / Server 2008"
      when "6.1" then "#{prefix} 7 / Server 2008 R2"
      when "6.2" then "#{prefix} 8"
      else "#{prefix} #{os_version}"
      end
    end

    def os_names_osx
      prefix = "Apple Mac OS X"
      case os_release
      when "10.0" then "#{prefix} #{os_version} (Cheetah)"
      when "10.1" then "#{prefix} #{os_version} (Puma)"
      when "10.2" then "#{prefix} #{os_version} (Jaguar)"
      when "10.3" then "#{prefix} #{os_version} (Panther)"
      when "10.4" then "#{prefix} #{os_version} (Tiger)"
      when "10.5" then "#{prefix} #{os_version} (Leopard)"
      when "10.6" then "#{prefix} #{os_version} (Snow Leopard)"
      when "10.7" then "#{prefix} #{os_version} (Lion)"
      else "#{prefix} #{os_version}"
      end
    end
  end
end
