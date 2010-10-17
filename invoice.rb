require 'rubygems' ; require 'bundler/setup'
$: << 'lib'
require 'egg_csa_invoice'


egg_csa_invoice do
  customer 'Sample customer'
  address  ['123 Street', 'City, IN', '317-xxx-xxxx']
  deposit    '8/1/2010', 50
  deliver  '10/11/2010', 4
end
