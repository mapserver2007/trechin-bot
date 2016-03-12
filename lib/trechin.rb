# -*- coding: utf-8 -*-
require 'trechin/crawler'
require 'trechin/util'
require 'trechin/mongo'
require 'time'

module Trechin
  class Runner
    include Trechin::Util

    def initialize(config = {})
      Logger.name = 'trechin'
      Logger.level = config[:test] ? 1 : 2 # 1=DEBUG, 2=INFO
      @mongo = Mongo.new("mlab.test.yml")
    end

    def run
      begin
        crawler = Crawler.new
        [1,2,3,4,5,6,7,8,9].each_parallel do |area|
          crawler.load_data(area)
        end

        train_data = crawler.get_data
        logger.info("Completion get the #{train_data.size.to_s} train services.")

        save_data = {
          :created_at => Time.now.strftime("%Y/%m/%d %H:%M:%S"),
          :data => train_data
        }

        registered_data = @mongo.get
        unless registered_data.empty?
          if @mongo.put(save_data, {:_id => registered_data[0]['_id']})
            logger.info("Updated train data.")
          else
            logger.error("Failed to updated new train data.")
          end
        else
          @mongo.post(save_data)
          logger.info("First registered train data.")
        end
      rescue => e
        logger.error(e)
      end
    end
  end
end
