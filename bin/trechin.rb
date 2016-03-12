# -*- coding: utf-8 -*-
$: << File.dirname(__FILE__) + "/../lib"
require 'trechin'
require 'optparse'
require 'thread'
require 'clockwork'
include Clockwork

config = {}
OptionParser.new do |opt|
  opt.on('-t', '--test') {|boolean| config[:test] = boolean}   # test mode
  opt.on('-v', '--version') {puts Trechin::VERSION; exit}    # version
  opt.parse!
end

handler do |job|
  trechin = Trechin::Runner.new(config)
  trechin.run
end

every(5.minutes, 'trechin-bot.job', :thread => true)
