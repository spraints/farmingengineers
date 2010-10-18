require 'ruport'
require 'ruport/util'
require 'farming_engineers'

module EggCsaInvoice

$invoice_count = 0
def egg_csa_invoice(&block)
  invoice = FarmingEngineers::Invoices::Eggs::Invoice.new
  invoice.instance_eval(&block)

  history_table = Table(:date, :description, :quantity, :total, :balance) do |t|
    balance = 0
    invoice.history.each do |line|
      balance += line.total
      t << [line.date, line.description, line.quantity, d(line.total), d(balance)]
    end
    t << ['', '', '', 'TOTAL', d(balance)]
  end

  history_table.rename_columns(
    :date => 'Date',
    :description => 'Description',
    :quantity => 'Quantity',
    :total => 'Total',
    :balance => 'Balance'
  )

  invoice_id = "#{Date.today.strftime('%Y%m%d')}-#{$invoice_count += 1}"
  invoice_file = File.expand_path("../invoice-#{invoice_id}.pdf", $0)
  puts invoice_file

  Ruport::Controller::Invoice.render :pdf, :file => invoice_file do |i|
    i.data = history_table
    i.options do |o|
      o.company_info  = "the farming engineers\nPO Box 1031\nWestfield, IN 46074"
      o.customer_info = "#{invoice.customer}\n#{invoice.address.join("\n")}"
      o.comments      = "#{invoice.notes}"
      o.order_info    = "Invoice #{invoice_id}"
      o.title         = "Egg delivery"
      o.body_width = 480
      o.comments_font_size = 12
      o.title_font_size = 10  
    end
  end
end
def d(amount)
  '$%0.2f' % amount
end

extend self
end

def egg_csa_invoice(&block)
  EggCsaInvoice.egg_csa_invoice(&block)
end
