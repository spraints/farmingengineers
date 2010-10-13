require 'rubygems' ; require 'bundler/setup'
require 'ruport'
require 'forwardable'

module InstanceEvalAttr
  def instance_eval_attr(*names)
    names.each do |name|
      varname= "@#{name}"
      define_method name do |*args|
        instance_variable_set(varname, args.first) unless args.empty?
        instance_variable_get(varname)
      end
      define_method "#{name}=" do |val|
        instance_variable_set(varname, val)
      end
    end
  end
end

class InvoiceController < Ruport::Controller
  stage :history

  def setup
    history_table = Table(:date, :description, :quantity, :total, :balance) do |t|
      balance = 0
      options[:invoice].history.each do |line|
        balance += line.total
        t << [line.date, line.description, line.quantity, line.total, balance]
      end
    end
    history_table.rename_columns(
      :date => 'Date',
      :description => 'Description',
      :quantity => 'Quantity',
      :total => 'Total',
      :balance => 'Balance'
    )
    self.data = history_table
  end
end

class PdfInvoice < Ruport::Formatter::PDF
  renders :pdf, :for => InvoiceController
  build :history do
    draw_table data, :width => 450
  end
end

class TextInvoice < Ruport::Formatter::Text
  renders :text, :for => InvoiceController
  build :history do
    render_table data
  end
end

module FarmingEngineers
  module Invoices
    class HistoryItem
      attr_reader :date, :description, :quantity, :total
    end
    class Deposit < HistoryItem
      def initialize(date, amount)
        @date = date
        @description = 'Deposit'
        @total = -amount
      end
    end
    class Eggs
      extend InstanceEvalAttr
      instance_eval_attr :customer, :address

      extend Forwardable
      def_delegators :@history, :deposit, :deliver

      attr_reader :history

      def initialize
        @history = EggHistory.new
      end

      class EggHistory < Array
        def deposit date, amount
          push Deposit.new(date, amount)
        end
        def deliver date, dozens
          push Delivery.new(date, dozens)
        end
      end

      class Delivery < FarmingEngineers::Invoices::HistoryItem
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
    end
  end
end

def egg_csa_invoice(&block)
  FarmingEngineers::Invoices::Eggs.new.tap { |i| i.instance_eval(&block) }
end


invoice = egg_csa_invoice do
  customer 'Sample customer'
  address  ['123 Street', 'City, IN', '317-xxx-xxxx']
  deposit    '8/1/2010', 50
  deliver  '10/11/2010', 4
end

puts invoice.inspect
puts InvoiceController.render(:text, :invoice => invoice)
InvoiceController.render(:pdf, :invoice => invoice, :file => 'invoice.pdf')
system 'open invoice.pdf'
