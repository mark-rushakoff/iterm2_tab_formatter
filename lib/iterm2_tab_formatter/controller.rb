require 'iterm2_escape'

module Iterm2TabFormatter
  class Controller
    def initialize(colors)
      @colors = colors
    end

    def apply_start_color
      Iterm2Escape::Tab.set_color(*@colors[:suite_start])
    end

    def apply_fail_color
      Iterm2Escape::Tab.set_color(*@colors[:spec_fail])
    end

    def apply_pass_color
      Iterm2Escape::Tab.set_color(*@colors[:suite_pass])
    end
  end
end
