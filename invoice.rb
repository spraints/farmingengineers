require 'rubygems' ; require 'bundler/setup'
$: << 'lib'
require 'egg_csa_invoice'


egg_csa_invoice(:id => '20101008-001') do
  customer 'Sample customer'
  address  ['123 Street', 'City, IN', '317-xxx-xxxx']
  deposit    '8/1/2010', 500
  deliver  '10/11/2010', 11
  deliver  '10/11/2010', 4, :rate => 4.50
  egg delivery '10/12/2010', 1
  line_item '11/1/2010', 'Another line item', 3, 4
  line_item :date => '11/2/2010', :description => 'Another line item', :total => 5
  purchase '11/1/2010', 'Doughnuts', 10
  notes 'Notes to customer'
end
