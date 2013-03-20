require 'rspec/core'

RSpec.configure do |c|
  c.add_setting(:it2tf_neutral, default: '#7F7F7F')
  c.add_setting(:it2tf_pass, default: '#00FF00')
  c.add_setting(:it2tf_fail, default: '#FF0000')
end
