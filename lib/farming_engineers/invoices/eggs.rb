
module FarmingEngineers ; module Invoices ; module Eggs
  class Invoice < Common::Invoice
    def initialize
      @history = History.new
    end
  end

  class History < Common::History
    def deliver date, dozens, opts = {}
      push Delivery.new(date, dozens, opts)
    end
  end

  class Delivery < Common::HistoryItem
    def initialize(date, dozens, opts = {})
      @date = date
      @description = 'Delivery'
      @quantity = dozens
      @total = calculate opts.merge(:dozens => dozens)
    end
    private
    def calculate opts
      opts[:total] ||
        opts[:dozens] * (opts[:rate] || opts[:price] ||
          if opts[:dozens] < 8
            5
          elsif opts[:dozens] < 12
            4.50
          else
            4
          end)
    end
  end
end ; end ; end
