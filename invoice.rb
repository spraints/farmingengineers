require 'rubygems' ; require 'bundler/setup'
require 'prawn'

pdf = Prawn::Document.new

pdf.save_font do
  pdf.font 'Courier'
  pdf.font_size 18
  pdf.text_box 'the farming engineers', :align => :right
end

pdf.text 'Invoice'

pdf.render_file('invoice.pdf')

system 'open', 'invoice.pdf'
