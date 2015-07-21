module FreezerBurn

  # Factory Pattern - Class to generate the correct Parser object, given type
  class Parser

    def configure(hosts)
      @logger.debug "No post-provisioning configuration necessary for #{self.class.name} boxes"
    end

    def self.register type, hosts_to_provision, options, config
      @logger = options[:logger]
      @logger.notify("Parser found some #{type} configurations to hook")
      case type.downcase
        when /pasivedns/
          return FreezerBurn::PassiveDNS.new()
        when /cxtracker/
          return FreezerBurn::Cxtracker.new()
        else
          report_and_raise(@logger, RuntimeError.new("Missing Class for parser invocation: (#{type})"), "Parser::register")
      end
    end
  end
end

%w( cxtracker pasivedns ).each do |lib|
  begin
    require "parsers/#{lib}"
  rescue LoadError
    require File.expand_path(File.join(File.dirname(__FILE__), "parsers", lib))
  end
end
