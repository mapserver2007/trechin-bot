# -*- coding: utf-8 -*-
require 'mechanize'
require 'parallel_runner'
require 'trechin/const'
require 'trechin/util'

module Trechin
  class Crawler
    include Trechin::Const
    include Trechin::Util

    def initialize
      @agent = create_agent
      @company = load_train_company
      @data = {}
    end

    def create_agent
      agent = Mechanize.new
      agent.user_agent_alias = "Windows IE 8"
      agent.read_timeout = CRAWLE_TIMEOUT
      agent
    end

    def get_data
      @data
    end

    def load_data(area)
      site = @agent.get(CRAWLE_URL % area)
      trainLines = (site/'//div[@class="labelSmall"]')
      trainLines.each do |elem|
        train_info = elem.next.next.search("tr")
        train_info.each do |tr|
          row = tr.search("td")
          next if row.empty?
          link = row.search("a").attribute("href").to_s
          train_no = link.split("/")[5]
          @data[train_no] = {
            :name => row[0].inner_text,
            :state => row[1].inner_text.gsub(/\[!\]/, ''),
            :link => link,
            :detail => ""
          }

          # 平常運転以外の場合、詳細情報を取得する
          unless row[1].xpath("span[@class='icnAlert']").empty?
            agent = create_agent
            site = agent.get(link)
            @data[train_no][:detail] = (site/'//dd[@class="trouble"]/p').inner_text
          end
        end
      end
    end

  end
end
