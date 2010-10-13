require 'rubygems' ; require 'bundler/setup'
require 'ruport'
require 'ruport/util'

class SampleReport < Ruport::Report
  include Invoice

  def renderable_data(format)
    render_invoice do |i|
      i.data = Table("Item Number", "Description", "Price") { |t|
        t << %w[101 Erlang\ The\ Movie $1000.00]
        t << %w[102 Erlang\ The\ Book $45.95]
      }
      i.company_info = "Company Name\nCompany Address"
      i.customer_info = "Customer Name\nCustomer Address"
      i.comments = "Random notes!"
      i.order_info = "Order info"
      i.title = "Invoice for this thing"
    end
  end
end

SampleReport.new.save_as 'invoice.pdf'
system 'open', 'invoice.pdf'
