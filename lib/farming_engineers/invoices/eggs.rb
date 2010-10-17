
module FarmingEngineers ; module Invoices ; module Eggs
  class Invoice < Common::Invoice
    def initialize
      @history = History.new
    end
  end

  class History < Common::History
    def deliver date, dozens
      push Delivery.new(date, dozens)
    end
  end

  class Delivery < Common::HistoryItem
    def initialize(date, dozens)
      @date = date
      @description = 'Delivery'
      @quantity = dozens
    end
    def total
      if @quantity < 8
        @quantity * 5
      elsif @quantity < 12
        @quantity * 4.50
      else
        @quantity * 4
      end
    end
  end
end ; end ; end
