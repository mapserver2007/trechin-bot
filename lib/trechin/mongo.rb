# -*- coding: utf-8 -*-
require 'net/https'
require 'json'
require 'trechin/const'
require 'trechin/util'

module Trechin
  class Mongo
    include Trechin::Const
    include Trechin::Util

    HOST = 'api.mlab.com'
    PATH = '/api/1/databases/%s/collections/%s'

    def initialize(file)
      config     = load_config("#{CONFIG_ROOT}/#{file}")
      database   = config['database']
      collection = config['collection']
      @apikey    = config['apikey']
      @path      = PATH % [database, collection]
      @header    = {'Content-Type' => "application/json"}
    end

    def get(cond = {})
      https_start do |https|
        JSON.parse(https.get(@path + "?apiKey=#{@apikey}" + (!cond.empty? ? "&q=" + cond.to_json : "")).body)
      end
    end

    def post(data)
      https_start do |https|
        https.post(@path + "?apiKey=#{@apikey}", data.to_json, @header).code == "200"
      end
    end

    def put(data, cond)
      https_start do |https|
        https.put(@path + "?apiKey=#{@apikey}&q=" + cond.to_json, data.to_json, @header).code == "200"
      end
    end

    def delete
      https_start do |https|
        https.delete(@path + "?apiKey=#{@apikey}", @header).code == "200"
      end
    end

    private
    def https_start
      Net::HTTP.version_1_2
      https = Net::HTTP.new(HOST, 443)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      https.start { yield https }
    end
  end
end
