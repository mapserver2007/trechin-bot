module Trechin
  module Const
    VERSION          = '0.0.1'
    CRAWLE_TIMEOUT   = 10
    CRAWLE_URL       = "http://transit.yahoo.co.jp/traininfo/area/%s/"
    CREWLE_USERAGENT = "Mozilla/5.0 (Android; Linux armv7l; rv:9.0) Gecko/20111216 Firefox/9.0 Fennec/9.0"
    CONFIG_ROOT      = File.dirname(__FILE__) + "/../../config"
  end
end
