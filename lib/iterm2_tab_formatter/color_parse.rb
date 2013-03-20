require 'iterm2_tab_formatter/base'

class Iterm2TabFormatter
  class << self
    def color_parse(code)
      regex = /\A#([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})\z/i
      raise ArgumentError, "Invalid format: #{code}. Use #RRGGBB" unless code.match(regex)

      code.scan(regex) do |red, green, blue|
        return [red.to_i(16), green.to_i(16), blue.to_i(16)]
      end
    end
  end
end
