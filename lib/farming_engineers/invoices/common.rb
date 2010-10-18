require 'instance_eval_attr'

module FarmingEngineers ; module Invoices ; module Common
  class Invoice
    extend InstanceEvalAttr
    instance_eval_attr :customer, :address, :notes

    attr_reader :history

    def method_missing(method, *args)
      history.send(method, *args)
    end
  end

  class HistoryItem
    attr_reader :date, :description, :quantity, :total
  end
  class LineItem < HistoryItem
    def initialize(*args)
      case args.first
      when Hash
        args = args.first
        @date = args[:date]
        @description = args[:description]
        @quantity = args[:quantity]
        @total = args[:total]
      else
        @date, @description, @quantity, @total = args
      end
    end
  end
  class Deposit < HistoryItem
    def initialize(date, amount)
      @date = date
      @description = 'Deposit'
      @total = -amount
    end
  end
  class Purchase < HistoryItem
    def initialize(date, description, amount)
      @date = date
      @description = description
      @total = amount
    end
  end
  class History < Array
    def self.generator(name, klass)
      define_method(name) do |*args|
        push klass.new(*args)
      end
    end
    generator :deposit, Deposit
    generator :purchase, Purchase
    generator :line, LineItem
    generator :line_item, LineItem
  end
end ; end ; end
