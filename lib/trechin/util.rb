# -*- coding: utf-8 -*-
require 'yaml'
require 'trechin/logger'

module Trechin
  module Util
    def logger; Logger.syslog end

    def load_config(file, config_key = nil)
      obj = File.exist?(file) ? YAML.load_file(file) : ENV
      config_key.nil? ? obj : obj[config_key]
    end
  end
end
