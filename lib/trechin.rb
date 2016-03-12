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
      @mongo = Mongo.new("mlab.yml")
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
        unless registered_data.nil? && registered_data.empty?
          if @mongo.put(save_data, {:_id => registered_data[0]['_id']})
            logger.info("Updated train data.")
          else
            logger.error("Failed to updated new train data.")
          end
        else
          logger.error("Can not get old train data. because update to new data failed.")
        end
      rescue => e
        logger.error(e)
      end
    end
  end
end
