begin
require 'iterm2_tab_formatter/base'
rescue LoadError
  warn "Couldn't load base class for Iterm2TabFormatter.  This might be okay if reading from the gemspec before running bundle install."
end

class Iterm2TabFormatter
  VERSION = "0.7.0"
end
