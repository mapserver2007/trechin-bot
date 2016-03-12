# -*- coding: utf-8 -*-
$: << File.dirname(__FILE__) + "/../lib"
require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')
include TrechinTest

describe Trechin do
  describe 'データ取得' do
    it '電車遅延情報を取得できること' do
      crawler = Trechin::Crawler.new
      crawler.load_data(1) # 関東
      data = crawler.get_data["21"] # 山手線
      expect(data[:name]).to eq("山手線")
      expect(data[:state]).not_to be_nil
      expect(data[:link]).not_to be_nil
      expect(data[:detail]).not_to be_nil
    end
  end
end
