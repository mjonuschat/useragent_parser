module UseragentParser
  class UserAgent
    attr_reader :browser, :browser_family, :browser_version, :browser_major_version, :browser_minor_version, :browser_patch_version
    attr_reader :os, :os_family, :os_version, :os_major_version, :os_minor_version, :os_patch_version

    def initialize(details = {})
      @browser_family = details['browser_family'] || 'Other'
      @browser_major_version = details['v1']
      @browser_minor_version = details['v2']
      @browser_patch_version = details['v3']

      @os_family = details['os_family'] || 'Other'
      @os_major_version = details['os_v1']
      @os_minor_version = details['os_v2']
      @os_patch_version = details['os_v3']
    end

    def browser_version
      @browser_version ||= "#{browser_major_version}.#{browser_minor_version}.#{browser_patch_version}".gsub(/\.+$/, '').strip
    end

    def os_version
      @browser_version ||= "#{os_major_version}.#{os_minor_version}.#{os_patch_version}".gsub(/\.+$/, '').strip
    end

    def os
      @os ||= os_name
    end

    def browser
      @browser ||= browser_name
    end

    protected

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
