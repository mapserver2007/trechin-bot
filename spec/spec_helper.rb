# -*- coding: utf-8 -*-
require 'rspec'
require File.dirname(__FILE__) + "/../lib/trechin"
require File.dirname(__FILE__) + "/../lib/trechin/crawler"
require File.dirname(__FILE__) + "/../lib/trechin/util"
require File.dirname(__FILE__) + "/../lib/trechin/mongo"

module TrechinTest
  include Trechin::Util
  TEST_CONFIG_ROOT = File.dirname(__FILE__) + "/config"

end
