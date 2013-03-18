require 'iterm2_tab_formatter'
require 'rspec/core/configuration'

RSpec.configure do |c|
  c.add_formatter(Iterm2TabFormatter)
end
