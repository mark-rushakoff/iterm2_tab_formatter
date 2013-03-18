# This file exists only so that we don't have to declare the base class
# anywhere else.  This is why modules are usually used for the top level, but
# in this case I think it has to be a class for RSpec to load the formatter
# properly.

require 'rspec/core/formatters/base_formatter'

class Iterm2TabFormatter < RSpec::Core::Formatters::BaseFormatter
end
