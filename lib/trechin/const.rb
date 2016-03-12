module Trechin
  module Const
    VERSION          = '0.0.1'
    CRAWLE_TIMEOUT   = 10
    CRAWLE_URL       = "http://transit.yahoo.co.jp/traininfo/area/%s/"
    CREWLE_USERAGENT = "Mac Mozilla"
    CONFIG_ROOT      = File.dirname(__FILE__) + "/../../config"
  end
end
