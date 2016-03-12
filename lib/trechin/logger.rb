require 'log4r'

module Trechin
  class Logger
    def self.method_missing(name, *args)
      if /(.*?)=$/ =~ name
        class_variable_set("@@#{$1}", args[0])
      end
    end

    def self.name=(name); @@name = name end

    def self.level=(level); @@level = level end

    def self.formatter=(formatter); @@formatter = formatter end

    def self.formatter
      Log4r::PatternFormatter.new(
        :pattern => "[%l] %d: %M",
        :date_format => "%Y/%m/%d %H:%M:%Sm"
      )
    end

    def self.syslog
      @@logger = nil
      return @@logger unless @@logger.nil?
      @@logger = Log4r::Logger.new(@@name)
      @@logger.level = @@level
      @@logger.outputters = []
      @@logger.outputters << Log4r::StdoutOutputter.new('console', {
          :formatter => formatter
      })
      @@logger
    end
  end
end
