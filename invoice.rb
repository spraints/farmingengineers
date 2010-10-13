#require 'rubygems' ; require 'bundler/setup'
#require 'ruport'
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

module FarmingEngineers
  module Invoices
    class Eggs
      extend InstanceEvalAttr
      instance_eval_attr :customer, :address

      extend Forwardable
      def_delegators :@activities, :deposit, :deliver

      def initialize
        @activities = Activities.new
      end

      class Activities < Array
        def deposit date, amount
          push Deposit.new(date, amount)
        end
        def deliver date, dozens
          push Delivery.new(date, dozens)
        end
      end

      class Delivery
        def initialize(date, dozens)
          @date = date
          @dozens = dozens
        end
      end
    end
    class Deposit
      def initialize(date, amount)
        @date   = date
        @amount = amount
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
